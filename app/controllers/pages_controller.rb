class PagesController < ApplicationController

  skip_before_filter :authorize, :only => [:welcome]

  def welcome
    redirect_to cohorts_path if authenticated?
  end
end
