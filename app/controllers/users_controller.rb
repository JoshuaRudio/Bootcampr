class UsersController < ApplicationController
  before_action :authenticate_user!, :except => [:index, :show]
  before_action :require_permission, :only => [:edit, :update, :destroy]

  def show
    @user = User.find(params[:id])
    @events = @user.events.order(:date, :time)
  end

  def edit
    @user = User.find(params[:id])
    render :edit
  end


  def update
    @user = User.find(params[:id])
    @user.assign_attributes(user_params)
    if @user.first_name == ''
      @user.first_name = nil
    end
    if @user.last_name == ''
      @user.last_name = nil
    end
    @user.tag_list = user_params[:tag_list]
    @user.save
    flash[:success] = "Your profile was updated."
    redirect_to @user
  end

  def subscriptions
    @user = User.find(params[:id])
    if @user == current_user
      @user.subscribed = !@user.subscribed
      @user.save
      success = 'You have successfully subscribed to emails.' if @user.subscribed
      success = 'You have successfully unsubscribed to emails.' if !@user.subscribed
      redirect_to user_path(@user), notice: success
    else
      redirect_to user_path(@user)
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :bootcamp, :location, :summary, :tag_list, :image, :email, :password, :github_handle, :twitter_handle, :website, :linkedin_handle)
  end

  def require_permission
    if current_user != User.find(params[:id])
      redirect_to root_path
    end
  end
end
