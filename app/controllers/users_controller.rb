class UsersController < ApplicationController

  def show
    @student = User.includes(:cohort, :exercise_attempts, :attempted_exercises, :challenge_attempts, :attempted_challenges).find(params[:id])

    @exercises = Exercise.all.sort
    @attempts_by_exercise_id = @student.exercise_attempts.group_by(&:exercise_id)

    @weeks = Week.includes(:challenges).where("id <= ?", @student.cohort.current_week)
    @attempts_by_challenge_id = @student.challenge_attempts.group_by(&:challenge_id)
  end
end
