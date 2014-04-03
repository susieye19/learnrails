class ChaptersController < ApplicationController
  before_action :set_chapter, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_correct_url, only: [:show]
  before_action :authenticate_user!

  # GET /chapters
  # GET /chapters.json
  def index
    @chapters = Chapter.all
    @comments = Comment.find(:all, limit: 15, order: 'created_at desc')
  end

  # GET /chapters/1
  # GET /chapters/1.json
  def show
    @chapters = Chapter.all
    @comments = @chapter.root_comments.order('created_at asc')
    @new_comment = Comment.build_from(@chapter, current_user, "")

    if current_user.amount > 0
      Analytics.identify(
        user_id: current_user.id,
        traits: {
          name: current_user.name,
          email: current_user.email,
          amount: current_user.amount
        }
      )
    else
      Analytics.identify(
        user_id: current_user.id,
        traits: {
          name: current_user.name,
          email: current_user.email,
          amount: "FREE"
        }
      )
    end

    Analytics.track(
      user_id: current_user.id,
      event: 'Viewed chapter',
      properties: {
        chapter: @chapter.title
      },
      context: {
        'Google Analytics' => {
          clientId: '471240751.1390206154'
        }
      }
    )
  end

  # GET /chapters/new
  def new
    @chapter = Chapter.new
  end

  # GET /chapters/1/edit
  def edit
  end

  # POST /chapters
  # POST /chapters.json
  def create
    @chapter = Chapter.new(chapter_params)

    respond_to do |format|
      if @chapter.save
        format.html { redirect_to @chapter, notice: 'Chapter was successfully created.' }
        format.json { render action: 'show', status: :created, location: @chapter }
      else
        format.html { render action: 'new' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /chapters/1
  # PATCH/PUT /chapters/1.json
  def update
    respond_to do |format|
      if @chapter.update(chapter_params)
        format.html { redirect_to @chapter, notice: 'Chapter was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @chapter.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /chapters/1
  # DELETE /chapters/1.json
  def destroy
    @chapter.destroy
    respond_to do |format|
      format.html { redirect_to chapters_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_chapter
      @chapter = Chapter.friendly.find(params[:id])
    end

    def redirect_to_correct_url
      # Redirect to the correct URL if the title of the chapter has since been changed
      if request.path != chapter_path(@chapter)
        return redirect_to @chapter, :status => :moved_permanently
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def chapter_params
      params.require(:chapter).permit(:title, :section, :notes, :transcript, :url)
    end
end
