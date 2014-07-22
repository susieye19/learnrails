class CoursesController < ApplicationController
  before_action :set_course, only: [:show]
	before_action :authenticate_user!, except: [:index]
  before_action :redirect_to_correct_url, only: [:show]

  def index
  	@courses = Course.all
	end

  def show
  	@chapters = Chapter.where(course: @course)
  	@comments = Comment.where(course_id: @course.id).find(:all, limit: 15, order: 'created_at DESC')
  end

  private
    def set_course
      @course = Course.friendly.find(params[:id])
    end

    def redirect_to_correct_url
      # Redirect to the correct URL if the title of the course has since been changed
      if request.path != course_path(@course)
        return redirect_to @course, :status => :moved_permanently
      end
    end
end
