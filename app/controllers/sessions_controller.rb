class SessionsController < ApplicationController
  before_action :check_login, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
    params[:user][:user_name],
    params[:user][:password]
    )

    if user.nil?
      flash[:errors] = ["Cannot find user with such name and password."]
      redirect_to(new_session_url)
    else
      login!(user)
      redirect_to(user_url(user))
    end
  end

  def destroy
    if params[:session]
      Session.find(params[:session]).destroy!
      render :index
    else
      Session.find_by(token: session[:session_token]).destroy!
      session[:session_token] = nil
      redirect_to new_session_url
    end
  end

  def index
    @sessions = Session.where(user_id: params[:user_id])
    render :index
  end

  private

  def check_login
    redirect_to cats_url if current_user
  end
end
