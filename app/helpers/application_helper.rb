module ApplicationHelper

  def current_user
    @current_user ||= User.find(session[:socrates_id]) if session[:socrates_id]
  end

  def set_email_cc(location)
    return "chicago.prep@devbootcamp.com" if location == "Chicago"
    return "sf.prep@devbootcamp.com" if location == "San Francisco"
    return ""
  end
end
