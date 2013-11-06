class SessionsController < ApplicationController

  def sign_in
    redirect_to '/auth/dbc'
  end

  def sign_out
    session.clear
    redirect_to root_path
  end

  def auth
    authenticated_user_attributes = request.env['omniauth.auth'].info
    puts "********************************************"
    puts session[:socrates_id]
    session[:socrates_id] = authenticated_user_attributes.id
    token = request.env['omniauth.auth'].credentials
    session[:oauth_token] = token_as_hash(token)

    redirect_to root_path
  end

  private
  def token_as_hash(token)
    { token: token.token,
      refresh_token: token.refresh_token,
      expires_at: token.expires_at }
  end

end
