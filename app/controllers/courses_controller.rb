class CoursesController < ApplicationController
	before_action :authenticate_user!, except: [:index]

  def index
  	@courses = Course.all
	end

  def show
  	@course = Course.find(params[:id])
  	@chapters = Chapter.where(course: @course)
  	@comments = Comment.where(course_id: @course.id).find(:all, limit: 15, order: 'created_at DESC')
  end
end
