module SessionsHelper
    

  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Remembers a user in a persistent session.
  def remember(user)
    user.remember
    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token
  end
  
  def current_user?(user)
  current_user == user # user 와 current user가 동일할 경우 true
  end
  
  
  
  # Returns the current logged-in user (if any).
  def current_user
    if (user_id = session[:user_id])
      @current_user ||= User.find_by(id: user_id)
    elsif (user_id = cookies.signed[:user_id])
    
      user = User.find_by(id: user_id)
     if user && user.authenticated?(:remember, cookies[:remember_token])
        log_in user
        @current_user = user
      end
    end
  end
  
  def logged_in?
    !current_user.nil?
  end
  
   # Forgets a persistent session.
  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end
  
  # 저장된 주소로 리다이렉트(or to the default)
  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default) 
    #session 안에 :forwading_url 값이 투르이면 :forwarding_url로 이동 아닐경우 default페이지로 이동
    session.delete(:forwarding_url) #이동후에는  :forwarding_url값 삭제
  end

  # 접속하려고 하느 URL 저장
  def store_location
    session[:forwarding_url] = request.url if request.get? 
  end

  


end
