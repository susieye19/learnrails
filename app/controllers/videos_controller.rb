class VideosController < ApplicationController
  before_action :check_user_permissions, except: [:index]
  before_action :set_video, only: [:show, :edit, :update, :destroy]
  before_action :redirect_to_correct_url, only: [:show]
  before_action :require_admin, except: [:index, :show]

  # GET /videos
  # GET /videos.json
  def index
    # Compile list of categories sorted alphabetically
    @categories = Video.all.to_a.map { |v| v.category }.uniq.sort_by{ |c| c.downcase }
  end

  # GET /videos/1
  # GET /videos/1.json
  def show
    @comments = @video.root_comments.order('created_at DESC')
    @new_comment = Comment.build_from(@video, current_user, "")
  end

  # GET /videos/new
  def new
    @video = Video.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  # POST /videos.json
  def create
    @video = Video.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render action: 'show', status: :created, location: @video }
      else
        format.html { render action: 'new' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video
      @video = Video.friendly.find(params[:id])
    end

    def redirect_to_correct_url
      # Redirect to the correct URL if the title of the video has since been changed
      if request.path != video_path(@video)
        return redirect_to @video, :status => :moved_permanently
      end
    end

    def check_user_permissions
      if user_signed_in?
        # User needs to have paid for extra_access
        unless current_user.extra_access
          flash[:error] = "The Video Library and Developer Q&A sections are available as a paid add-on for students"
          redirect_to new_charge_path
        end
      else
        # User needs to be signed in first
        flash[:error] = "You must be logged in to access this section"
        redirect_to new_user_session_path
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_params
      params.require(:video).permit(:title, :description, :category, :notes, :transcript, :url)
    end
end
