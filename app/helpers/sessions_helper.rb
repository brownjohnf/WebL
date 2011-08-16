module SessionsHelper

  def sign_in(user)
    cookies.permanent.signed[:remember_token] = [user.id, user.cookie_hash]
    self.current_user = user
  end

  def sign_out
    cookies.delete(:remember_token)
    self.current_user = nil
  end
  
  def signed_in?
    !current_user.nil?
  end
  
  def current_user
    @current_user ||= user_from_remember_token
  end
  
  def current_user?(user)
    current_user == user
  end
  
  def current_user=(user)
    @current_user = user
  end

	def authenticate
		deny_access unless signed_in?
	end

  def deny_access
    store_location
    flash[:notice] = "Please sign in to access this page."
    redirect_to signin_path
  end
  
  def redirect_back_or(default)
    redirect_to(session[:return_to] || default)
    clear_return_to
  end

	def redirect_back
		redirect_to(request.referer)
	end
  
  private
  
    def user_from_remember_token
      User.authenticate_with_cookie(*remember_token)
    end
    
    def remember_token
      cookies.signed[:remember_token] || [nil, nil]
    end
    
    def store_location
      session[:return_to] = request.fullpath
    end

		def store_referer
			session[:return_to] ||= request.referer
		end
    
    def clear_return_to
      session[:return_to] = nil
    end
end
