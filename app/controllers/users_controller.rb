class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]
  before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
  def index
    if current_user
      redirect_to "users/#{current_user.id}"
    else 
      redirect_to "sessions/new"
    end
  end

  def show
    @seeks = Seek.all
    # if current_user
    #   render 'show'
    # else 
    #   redirect_to '/sessions/new'
    # end
  end

  def new
    user = current_user
    if current_user
      redirect_to "/users/#{user.id}"
    else 
      render 'new'
    end
  end

  def create
    user = User.new(get_user_info)
    if user.valid?
      user.save
      session[:user_id] = user.id
      redirect_to "/users/#{user.id}", notice: "You have successfully registered!"
    else
      redirect_to :back , alert: user.errors.full_messages
    end
  end

  def edit
    # if current_user
    #   render 'edit'
    # else 
    #   redirect_to '/sessions/new'
    # end
  end

  def update
    user = User.update(@user.id, get_user_info)
    # user = User.update(current_user.id, get_user_info)
    # updated = current_user.update(get_user_info)
    if user.valid?
      redirect_to "/users/#{current_user.id}", notice: "You have successfully updated your profile!"
    else
      redirect_to :back, alert: user.errors.full_messages
    end
  end

  def destroy
    user = @user.destroy
    
    if user
      session[:user_id] = nil
      redirect_to "/sessions/new", notice: "You have successfully deleted the user!"
    else
      redirect_to :back, alert: "Somethinfg went wrong while deleiting!"
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
    # @user = current_user
  end
  def get_user_info
    # params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
