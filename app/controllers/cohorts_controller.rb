class CohortsController < ApplicationController

  def index
    @weeks = Week.includes(:cohorts, :challenges).all.select { |w| w.cohorts.any? }
  end

  def show
    @cohort = Cohort.includes(students: [:attempted_exercises, :attempted_challenges]).find(params[:id])
    @challenges_due = Week.includes(:challenges).where("id < ?", @cohort.current_week).map(&:challenges).flatten
    @exercises_due = Exercise.all
  end

end
