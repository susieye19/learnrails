class CommentsController < ApplicationController
  before_action :authenticate_user!
  
  def upvote
    @comment = Comment.find(params[:id])
    @comment.upvote_by current_user
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: { count: @comment.votes_for.size } }
    end
  end
  
  def unvote
    @comment = Comment.find(params[:id])
    @comment.unliked_by current_user
    redirect_to :back
  end

  def create
    @comment_hash = params[:comment]
    @obj = @comment_hash[:commentable_type].constantize.find(@comment_hash[:commentable_id])
    @comment = Comment.build_from(@obj, current_user.id, @comment_hash[:body])
    @comment.user_name = current_user.name

    # Set course_id if comment is posted to a Chapter
    if @comment.commentable_type == "Chapter"
      @comment.course_id = Chapter.find(@comment.commentable_id).course_id
    end

    # Prepare a new_comment object in case user wants to post another comment
    @new_comment = Comment.build_from(@obj, current_user, "")

    unless (params[:comment][:parent_id].blank?)
      @parent = Comment.find(params[:comment][:parent_id])
    end

    if @comment.save

      if @parent
        # Send a comment reply notification to the parent user
        UserMailer.comment_reply_notification(@parent.user.email, @parent.user.name, @comment.user.name, @comment.body, request.referrer).deliver

        # Send Alex a new comment notification if Alex wasn't involved
        if (@parent.user.email != "alex@baserails.com") && (@comment.user.email != "alex@baserails.com")
          UserMailer.new_comment(@comment.user.name, @comment.body, request.referrer).deliver
        end

        @comment.move_to_child_of(@parent)
      else
        # Send Alex a new comment notification if Alex wasn't involved
        unless @comment.user.email == "alex@baserails.com"
          UserMailer.new_comment(@comment.user.name, @comment.body, request.referrer).deliver
        end
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
