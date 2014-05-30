class SessionsController < ApplicationController
  #must be signed out to create a new session (sign in)
  before_action :require_signed_out!, :only => [:new, :create]
  #must be signed in to end a session (sign out)
  before_action :require_signed_in!, :only => [:destroy]
  
  def new #log-in page
  end
  
  def create
    @user = User.find_by_credentials(
      user_params[:email]
      user_params[:password]
    )
    
    if @user
      log_in_user!(@user)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ["Invalid Credentials"]
      render :new
    end
    #reset session[:token] and user.token
    #redirect to user#show
  end
  
  def destroy #reset user's token and session's token
    current_user.reset_session_token!
    session[:session_token] = nil
    
    redirect_to new_session_url
  end
  
  private
  
  def user_params
    params.require(:user_params).permit(:username, :password)
  end
end
