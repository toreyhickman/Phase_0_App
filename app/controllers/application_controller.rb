class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authorize

  helper_method :authenticated?


  def authorize
    redirect_to 'pages#welcome' unless session[:socrates_id]
  end

  def authenticated?
    session[:socrates_id]
  end
end
