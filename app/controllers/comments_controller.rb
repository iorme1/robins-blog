class CommentsController < ApplicationController
  invisible_captcha only: [:create, :update], honeypot: :subtitle, on_spam: :spam_detected
  before_action :authorize_user, except: [:index, :like, :show, :replies]
  before_action :set_post, only: [:create, :destroy, :like, :replies]
  before_action :set_comment, only: [:edit, :update, :like, :show, :replies]

  def show
  end

  def create
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    if @comment.save
      flash[:notice] = "Your comment has been added."
    else
      flash[:alert] = "Comment failed to save. Please try again."
      redirect_to @post
    end
  end

  def edit
    @post = @comment.post
  end

  def update
    @post = @comment.post
    @comment.assign_attributes(comment_params)

    if @comment.save
      flash[:notice] = "Your comment has been updated."
      redirect_to @post
    else
      flash.now[:alert] = "Your comment failed to update. Please try again."
      render :edit
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])

    if @comment.destroy
      flash[:notice] = "Your comment was removed."
      redirect_to @post
    else
      flash[:alert] = "Your comment could not be removed. Please try again."
      redirect_to @post
    end
  end

  def replies
  end

  def like
    @like = Like.where(likeable: @comment, user_id: current_user)

    unless @like.size >= 1
      Like.create(likeable: @comment,  user: current_user, like: params[:like])
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

  def spam_detected
    redirect_to root_path
  end

  def authorize_user
    unless current_user
      flash[:alert] = "You must be atleast a member to comment. Sign up for free now!"
      redirect_to root_path
    end
  end
end
