class UsersController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new user_params
    if @user.save
      session[:current_user_id] = @user.id
      flash[:notice] = "User successfully created!"
      redirect_to root_url
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username)
  end
end
