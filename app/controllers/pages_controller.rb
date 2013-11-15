class PagesController < ApplicationController

  skip_before_filter :authorize, :only => [:index]
  skip_before_filter :get_cohorts, :only => [:index]

  def index
    redirect_to cohorts_path and return if authenticated?
    render layout: "landing" and return if flash[:notice]
    redirect_to signin_path and return
  end
end
