module ApplicationHelper

  def current_user
    @current_user ||= User.find(session[:socrates_id]) if session[:socrates_id]
  end
end
