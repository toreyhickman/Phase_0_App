class UsersController < ApplicationController

  def show
    @student = User.includes(:cohort, :exercise_attempts, :attempted_exercises, :challenge_attempts, :attempted_challenges).find(params[:id])

    @exercises = Exercise.all.sort
    @attempts_by_exercise_id = @student.exercise_attempts.group_by(&:exercise_id)

    @weeks = Week.includes(:challenges).where("id <= ?", @student.cohort.current_week)
    @attempts_by_challenge_id = @student.challenge_attempts.group_by(&:challenge_id)

    @challenges_due = @weeks[0..-2].map(&:challenges).reduce(&:+)
    @challenges_due = [] if @challenges_due == nil

    all_attempts = (@student.exercise_attempts + @student.challenge_attempts).reject { |x| x.submitted_at == nil }
    @last_attempt = [all_attempts.max_by(&:submitted_at)].compact
  end

  def toggle_flag
    respond_to do |format|
      format.json do
        user = User.find(params[:user_id])

        if params[:flag] == "intellectual_flag"
          user.intellectual_flag = !user.intellectual_flag
          color = "#{user.intellectual_flag ? 'red' : 'green'}"
        else
          user.cultural_flag = !user.cultural_flag
          color = "#{user.cultural_flag ? 'red' : 'green'}"
        end

        user.save

        render :json => {color: color}
      end
    end
  end
end
