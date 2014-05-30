class UsersController < ApplicationController
  #only show user profile if signed in
  before_action :require_signed_in!, :only => [:show]
  #must be signed out to create a new user (and then sign in)
  before_action :require_signed_out!, :only => [:create, :new]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    
    if @user.save
      log_in_user!(@user)
      redirect_to user_url(user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
  
  def show
    if params.include?(:id)
      @user = User.find(params[:id])
    else
      redirect_to user_url(current_user)
    end
  end
  
  private
  
  def user_params
    params.require(:user_params).permit(:email, :password)
  end
end
