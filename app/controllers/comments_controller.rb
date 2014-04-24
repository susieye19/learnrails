class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment_hash = params[:comment]
    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])

    # Prepare a new_comment object in case user wants to post another comment
    @new_comment = Comment.build_from(@obj, current_user, "")

    unless (params[:comment][:parent_id].blank?)
      @parent = Comment.find(params[:comment][:parent_id])
    end

    if @comment.save
      if @parent
        UserMailer.comment_notification(@parent.user.email, @parent.user.name, @comment.user.name, @comment.body).deliver
        @comment.move_to_child_of(@parent)
      end

      unless @comment.user.email == "alex@baserails.com"
        UserMailer.alex_notification(@comment.user.name, @comment.body).deliver
      end

      render :partial => "comments/comment", locals: { comment: @comment, new_comment: @new_comment },
          layout: false, status: :created
    else
      render :js => "alert('Error saving comment');"
    end
  end

  def destroy
    @comment = Comment.find(params[:id])

    # # Set parent_id of child comments to parent of @comment
    # if @comment.has_children?
    #   @comment.children.each do |child|
    #     child.parent_id = @comment.parent_id
    #   end
    # end

    if @comment.destroy
      render :json => @comment, :status => :ok
    else
      render :js => "alert('Error deleting comment');"
    end
  end
end
