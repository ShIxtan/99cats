

class UsersController < ApplicationController
  before_action :check_login, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    redirect_to cats_url
  end

  private
  def user_params
    params.require(:user).permit(:user_name, :password)
  end

  def check_login
    redirect_to cats_url if current_user
  end

end
