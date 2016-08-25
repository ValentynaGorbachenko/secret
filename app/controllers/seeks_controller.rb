class SeeksController < ApplicationController
  before_action :set_user, only: [:index, :destroy]
  before_action :require_login, only: [:index, :create, :destroy]
  def index
    @secrets = Seek.all
  end

  def create
    seek = Seek.new(get_seek_info)
    if seek.valid?
      seek.save
      #"/users/#{@user.id}"
      redirect_to :back, notice: "You have successfully created a secret!"
    else
      redirect_to :back , alert: seek.errors.full_messages
    end
  end

  def destroy
    # fail
    seek = Seek.find(params[:id])
    if seek.user == @user

      deleted = seek.destroy
      if deleted
        redirect_to "/users/#{@user.id}", notice: "You have successfully deleted your secret!"
      else
        redirect_to "/users/#{@user.id}", alert: "Something went wrong while deleting, please try again!"
      end
    else 
        redirect_to "/users/#{@user.id}", alert: "You not allowed to do that!"

    end
  end

  private
  def set_user
    @user = current_user
  end
  def get_seek_info
    params.require(:seek).permit(:content).merge(user: current_user)
  end
end
