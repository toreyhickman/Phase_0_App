class SessionsController < ApplicationController

  skip_before_filter :authorize

  def sign_in
    redirect_to '/auth/dbc'
  end

  def sign_out
    session.clear
    redirect_to '/'
  end

  def auth
    authenticated_user_attributes = request.env['omniauth.auth'].info

    if User.find(authenticated_user_attributes.id).admin
      session[:socrates_id] = authenticated_user_attributes.id
      token = request.env['omniauth.auth'].credentials
      session[:oauth_token] = token_as_hash(token)
      redirect_to cohorts_path
    else
      redirect_to root_url, notice: "You do not have sufficient access privileges."
    end


  end

  private
  def token_as_hash(token)
    { token: token.token,
      refresh_token: token.refresh_token,
      expires_at: token.expires_at }
  end

  def authorized_roles
    ["admin", "ta", "editor"]
  end

end
