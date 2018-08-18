class CommentsController < ApplicationController
  before_action :authorize_user, except: [:index, :like]
  before_action :set_post, only: [:create, :destroy, :like]
  before_action :set_comment, only: [:edit, :update, :like]

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      UserMailer.comment_notification(@post, @comment).deliver
      flash[:notice] = "Comment saved successfully."
    else
      flash[:alert] = "Comment failed to save. Please try again."
    end
  end

  def edit
    @post = @comment.post
  end

  def update
    @post = @comment.post
    @comment.assign_attributes(comment_params)

    if @comment.save
      flash[:notice] = "Comment has been updated."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error updating that comment. Please try again."
      render :edit
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Comment was deleted."
      redirect_to @post
    else
      flash[:alert] = "Comment couldn't be deleted. Please try again."
      redirect_to @post
    end
  end

  def like
    @like = Like.where(likeable: @comment, user_id: current_user)

    unless @like.size >= 1
      Like.create(likeable: @comment,  user: current_user, like: params[:like])
      @recipient = User.where(subscription: true).where(id: @comment.user_id).pluck(:email)
      UserMailer.like_comment_notification(@recipient, current_user.email.split('@')[0], @post, @comment).deliver
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def authorize_user
    unless current_user.member? || current_user.admin?
      flash[:alert] = "You must be atleast member to comment. Sign up for free now!"
      redirect_to root_path
    end
  end
end
