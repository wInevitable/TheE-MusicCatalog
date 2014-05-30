module SessionsHelper
  
  def current_user
    User.find_by_token(session[:session_token])
  end
  
  def current_user_id
    current_user ? current_user.id : nil    
  end
  
  def log_in_user!(user)
    user.reset_session_token!
    session[:session_token] = user.token
  end
  
  def require_user!
    redirect_to sessions_url if current_user.nil?
  end
  
  def require_signed_in!
    redirect_to new_session_url unless signed_in?
  end
  
  def require_signed_out!
    redirect_to user_url(current_user) if signed_in?
  end
  
end
