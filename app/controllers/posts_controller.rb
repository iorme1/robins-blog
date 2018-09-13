class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy, :like, :replies]
  before_action :authorize_user, except: [:index, :show, :subscribe, :like]
  before_action :authorize_like, only: [:like]

  def index
    ahoy.track "Viewed Home Page"
    @posts = Post.published.page params[:page]
  end

  def show
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      flash[:notice] = "Your blog post was successfully added."
      redirect_to @post
    else
      flash[:alert] = "There was an error creating your blog post. Please try again."
      render :new
    end
  end

  def edit
  end

  def update
    @post.assign_attributes(post_params)

    if @post.save
      flash[:notice] = "Your blog post has been successfully updated."
      redirect_to @post
    else
      flash.now[:alert] = "There was an error updating your blog post. Please try again."
      render :edit
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Your blog post was removed."
      redirect_to root_path
    else
      flash[:alert] = "Your blog post could not be removed. Please try again."
      redirect_to root_path
    end
  end

  def draft
    @drafts = Post.draft
  end

  #this needs to be moved to the users controller and refactored as well
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
        flash[:alert] = "You are now unsubscribed."
        redirect_to root_path
      end
    else
      flash[:warning] = "There was an error. Please try again."
      redirect_to root_path
    end
  end

  def like

    @like = Like.where(likeable: @post, user_id: current_user)

    unless @like.size >= 1
      Like.create(likeable: @post, user: current_user, like: params[:like])
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :body, :cover, :draft, :notify)
  end

  def set_post
    @post = Post.find(params[:id])
  end

  def authorize_user
    unless current_user && current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path
    end
  end

  def authorize_like
    unless current_user
      flash[:alert] = "You must be signed in to like a post. Don't forget to check the Remember Me box to avoid having to sign in every time!"
      redirect_to new_user_session_path
    end
  end
end
