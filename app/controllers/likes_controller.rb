class LikesController < ApplicationController
  before_action :require_login, only: [:create, :destroy]
  # before_action :require_correct_user, only: [:create, :destroy]

  def create
    unless current_user.likes.where(seek: Seek.find(params[:id])).first
      current_user.likes.create(seek: Seek.find(params[:id]))
      redirect_to "/seeks"
    else
      redirect_to "/users/#{current_user.id}"
    end
  end
  def destroy
    if current_user.likes.where(seek: Seek.find(params[:id])).first
      current_user.likes.where(seek: Seek.find(params[:id])).first.destroy
      redirect_to "/seeks"
    else
      redirect_to "/users/#{current_user.id}"
    end
  end
end
