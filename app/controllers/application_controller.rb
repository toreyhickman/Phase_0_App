class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_filter :authorize, :get_cohorts

  helper_method :authenticated?


  def authorize
    redirect_to 'pages#welcome' unless session[:socrates_id]
  end

  def authenticated?
    session[:socrates_id]
  end

  def get_cohorts
    @cohorts = divide_by_location(Cohort.not_started.not_melt_or_hold)
  end

  def divide_by_location(cohorts)
    cohorts_by_location = { "San Francisco" => [], "Chicago" => [], "New York" => [] }
    cohorts.each do |cohort|
      cohorts_by_location[cohort.location] << cohort
    end
    cohorts_by_location
  end
end
