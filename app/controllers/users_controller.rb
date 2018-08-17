class UsersController < ApplicationController
  before_action :authorize_user

  def index
    @users = User.all
  end

  private

  def authorize_user
    unless current_user.admin?
      flash[:alert] = "You must be an admin to do that."
      redirect_to root_path
    end
  end
end
