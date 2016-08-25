class SessionsController < ApplicationController

  def new
    user = current_user
    if user
      redirect_to "/users/#{user.id}"
    else
      render 'new'
    end
  end
  # login
  def create
    user = User.find_by(email: get_login_info[:email])
    if user && user.authenticate(get_login_info[:password])
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}", notice: "You have successfully logged in!"
    else
      redirect_to :back, alert: ["Invalid email or password"]
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to "/sessions/new", notice: "You have successfully logged out!"
  end

  private
  def get_login_info
    params.require(:user).permit(:email, :password)
  end
end
