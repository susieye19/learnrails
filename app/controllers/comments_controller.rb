class CommentsController < ApplicationController

  def create
    @chapter = Chapter.friendly.find(params[:chapter_id])
    @new_comment = Comment.build_from(@chapter, current_user, "")
    @comment_hash = params[:comment]
    @comment = Comment.build_from(@chapter, current_user.id, @comment_hash[:body])
    @comment.chapter_id = @chapter.id

    if (params[:comment].has_key?(:parent_id))
      @parent = Comment.find(params[:comment][:parent_id])
    end

    if @comment.save
      if @parent
        UserMailer.comment_notification(@parent.user.email, @parent.user.name, @comment.user.name, @comment.body, @chapter.id).deliver
        @comment.move_to_child_of(@parent)
      end

      puts @comment.user.email
      unless @comment.user.email == "alex@baserails.com"
        puts "Inside unless statement"
        UserMailer.alex_notification(@comment.user.name, @comment.body).deliver
      end
      render :partial => "comments/comment", locals: { comment: @comment, new_comment: @new_comment, chapter: @chapter }, layout: false, status: :created
    else
      render :js => "alert('Error saving comment');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    if @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('Error deleting comment');"
    end
  end
end
