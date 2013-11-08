class UsersController < ApplicationController

  def show
    @student = User.includes(:cohort, :exercise_attempts, :attempted_exercises).find(params[:id])
    @exercises = Exercise.all.sort

    @attempts_by_exercise_id = @student.exercise_attempts.group_by(&:exercise_id)
  end
end
