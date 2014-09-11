class QuestionsController < ApplicationController
  before_action :set_question, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :create]
  before_action :redirect_to_correct_url, only: [:show]
  before_action :check_permission, only: [:new, :create]
  before_action :require_admin, only: [:edit, :update, :destroy]

  # GET /questions
  # GET /questions.json
  def index
    @questions = Question.all.order('created_at DESC')#.limit(5)
    #@replies = Comment.where(commentable_type: "Question").order('created_at DESC').limit(5)
  end

  # GET /questions/1
  # GET /questions/1.json
  def show
    @comments = @question.root_comments.order('created_at DESC')
    @new_comment = Comment.build_from(@question, current_user, "")
  end

  # GET /questions/new
  def new
    @question = Question.new
  end

  # GET /questions/1/edit
  def edit
  end

  # POST /questions
  # POST /questions.json
  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    @question.user_name = current_user.name

    respond_to do |format|
      if @question.save
        UserMailer.question_notification(current_user.name, @question.subject, @question.details).deliver
        format.html { redirect_to @question, notice: 'Question was successfully created.' }
        format.json { render action: 'show', status: :created, location: @question }
      else
        format.html { render action: 'new' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /questions/1
  # PATCH/PUT /questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        format.html { redirect_to @question, notice: 'Question was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /questions/1
  # DELETE /questions/1.json
  def destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to questions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_question
      @question = Question.friendly.find(params[:id])
    end
    
    def redirect_to_correct_url
      # Redirect to the correct URL if the title of the video has since been changed
      if request.path != question_path(@question)
        return redirect_to @question, :status => :moved_permanently
      end
    end

    def check_permission
      if current_user.plan.blank?
        redirect_to subscribe_path, notice: "You need to be subscribed to access this content"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def question_params
      params.require(:question).permit(:subject, :details)
    end
end
