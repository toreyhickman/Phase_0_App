class CohortsController < ApplicationController

  def index
  end

  def show
    @cohort = Cohort.includes(:students).find(params[:id])
  end

end
