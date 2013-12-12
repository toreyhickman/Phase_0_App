module ApplicationHelper

  def current_user
    @current_user ||= User.find(session[:socrates_id]) if session[:socrates_id]
  end

  def set_email_cc(location)
    return "chicago.prep@devbootcamp.com" if location == "Chicago"
    return "sf.prep@devbootcamp.com" if location == "San Francisco"
    return ""
  end

  def last_submission_date(attempts)
    most_recent_attempt = attempts.reject { |x| x.submitted_at == nil }.max_by(&:submitted_at)
    days = calculate_days_since(most_recent_attempt.submitted_at)

    case days
    when 0 then return "today"
    when 1 then return "yesterday"
    else return "#{days} days ago"
    end
  end

  private

  def calculate_days_since(date)
    (Date.today - date.to_date).to_i
  end
end
