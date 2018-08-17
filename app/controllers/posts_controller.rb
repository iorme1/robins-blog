class PostsController < ApplicationController
  before_action :set_post, only: [:show, :destroy, :edit, :update]
  before_action :authorize_user, except: [:index, :show, :subscribe]

  def index
    @posts = Post.where(draft: [nil, false]).order("created_at DESC")
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    @recipients = User.where(subscription: true).pluck(:email)

    if @post.save
      if !@post.draft
          @recipients.each do |recipient|
            UserMailer.post_notification(recipient, @post).deliver
          end
      end
      flash[:notice] = "Blog post successfully created."
      redirect_to @post
    else
      flash[:alert] = "There was an error creating the blog post. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)

    if @post.save
      if !@post.draft?
        UserMailer.post_notification(@post).deliver
      end
      flash[:notice] = "Blog post has been updated."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error updating the blog post. Please try again."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Blog post was deleted."
      redirect_to root_path
    else
      flash[:alert] = "Blog post could not be deleted. Please try again."
      redirect_to root_path
    end
  end

  def draft
    @drafts = Post.where(draft: true)
  end

  def subscribe
    if current_user.subscription?
      current_user.subscription = false
    else
      current_user.subscription = true
    end

    if current_user.save
      if current_user.subscription?
        flash[:notice] = "You have successfully subscribed!"
        redirect_to root_path
      else
        flash[:notice] = "You are now unsubscribed."
        redirect_to root_path
      end
    else
        flash[:warning] = "There was an error. Please try again."
        redirect_to root_path
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :cover, :draft)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path
    end
  end
end
