class PagesController < ApplicationController

  skip_before_filter :authorize, :only => [:welcome]

  def welcome
    @cohorts = Cohort.not_started.not_melt_or_hold
  end
end
