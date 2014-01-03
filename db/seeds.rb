require 'benchmark'
require 'date'




def calculate_current_week(start_date)
  current_week = 12 - ((Date.parse(start_date) - Date.today).to_i - 1)/7

  return 0 if current_week < 1
  return 13 if current_week > 12
  current_week
end

def assign_weekly_challenges
  { 1  => [417, 435, 418, 419, 421, 470],
    2  => [426, 427, 428, 425],
    3  => [432, 431, 434, 429],
    4  => [437, 438, 440, 439],
    5  => [441, 442, 444, 55],
    6  => [448, 452, 451, 454],
    7  => [457, 458, 106, 104],
    8  => [462, 113, 463],
    9  => [465, 466, 467, 468, 469],
    10 => [471, 473, 476],
    11 => [496, 464, 481, 482],
    12 => [404, 491, 494] }
end

def find_phase_zero_challenge_ids
  assign_weekly_challenges.values.flatten
end

def assign_exercises
  [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 15, 18, 19, 20, 21, 24, 25]
end

def dbc_admin?(dbc_user)
  user_admin_roles = ["editor", "admin", "ta"] & dbc_user.roles
  user_admin_roles.any?
end




puts (Benchmark.realtime {

# Seed weeks
(1..12).each { |n| Week.find_or_create_by(name: "Week #{n}") }

# Seed required challenges for each week
RequiredChallenge.delete_all

assign_weekly_challenges.each do |key, value|
  value.each do |challenge_id|
    RequiredChallenge.create(week_id: key, challenge_id: challenge_id)
  end
end

# Seed all of the cohorts
Cohort.delete_all

cohorts = DBC::Cohort.all.reject(&:in_session).keep_if do |c|
  year = c.name.slice(/\d{4}/)
  year != nil && year.to_i >= 2014
end

cohorts.each do |c|
  cohort = Cohort.find_or_initialize_by(socrates_id: c.id)

  cohort.socrates_id = c.id unless cohort.socrates_id
  cohort.name = c.name
  cohort.email = c.email
  cohort.location = c.location
  cohort.start_date = c.start_date
  cohort.in_session = c.in_session
  cohort.current_week = calculate_current_week(c.start_date)

  cohort.save
end

# Seed all users
User.delete_all

users = DBC::User.all
cohorts_in_db_ids = Cohort.all.map(&:socrates_id)

users.each do |user|
  admin_status = dbc_admin?(user)

  if cohorts_in_db_ids.include?(user.cohort_id) || admin_status
    user = User.create(socrates_id: user.id,
                       cohort_id: user.cohort_id,
                       name: user.name,
                       email: user.email,
                       github: user.profile[:github],
                       twitter: user.profile[:twitter],
                       blog_url: user.profile[:blog],
                       bio: user.profile[:about],
                       admin: admin_status)
  end
end

# Seed all exercises
Exercise.delete_all

exercises = DBC::Exercise.all

exercises.each do |e|
  if assign_exercises.include?(e.id)
    Exercise.create(socrates_id: e.id, title: e.title)
  end
end

# Seed all Phase 0 challenges
phase_zero_challenge_ids = find_phase_zero_challenge_ids

challenges = DBC::Challenge.all

challenges.each do |c|
  if phase_zero_challenge_ids.include?(c.id)
    challenge = Challenge.find_or_initialize_by(socrates_id: c.id)
    challenge.socrates_id = c.id unless challenge.socrates_id
    challenge.name = c.name
    challenge.save
  end
end

# Seed all exercise and challenge attempts
ExerciseAttempt.delete_all
ChallengeAttempt.delete_all

cohorts = Cohort.not_started.not_melt_or_hold

cohorts.each do |cohort|
  cohort.students.each do |student|

    # Exercises
    exercise_attempts = DBC::ExerciseAttempt.all(student.socrates_id)

    exercise_attempts.each do |exercise_attempt|

      if assign_exercises.include?(exercise_attempt.exercise_id)

        data = { exercise_id: exercise_attempt.exercise_id,
                 user_id: student.socrates_id,
                 code: exercise_attempt.code,
                 submitted_at: exercise_attempt.created_at }

        found_attempt = ExerciseAttempt.where(exercise_id: exercise_attempt.exercise_id, user_id: student.socrates_id).first

        if found_attempt.nil?
          ExerciseAttempt.create(data)
        elsif Date.parse(exercise_attempt.created_at) > found_attempt.submitted_at
          found_attempt.update_attributes(code: data[:code], submitted_at: data[:submitted_at])
        end
      end
    end

    # Challenges
    challenge_attempts = DBC::ChallengeAttempt.all(student.socrates_id)

    challenge_attempts.each do |challenge_attempt|

      if phase_zero_challenge_ids.include?(challenge_attempt.challenge_id)

        data = { challenge_id: challenge_attempt.challenge_id,
                 user_id: student.socrates_id,
                 repo: challenge_attempt.repo,
                 submitted_at: challenge_attempt.finished_at }

        found_attempt = ChallengeAttempt.where(challenge_id: challenge_attempt.challenge_id, user_id: student.socrates_id).first

        if found_attempt.nil?
          ChallengeAttempt.create(data)
        elsif challenge_attempt.finished_at.nil? || found_attempt.submitted_at.nil? || Date.parse(challenge_attempt.finished_at) > found_attempt.submitted_at
          found_attempt.update_attributes(data)
        end
      end
    end
  end
end

}.to_f/60).to_s + " minutes"
