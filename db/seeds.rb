require 'benchmark'
require 'date'




def calculate_current_week(start_date)
  current_week = 12 - (Date.parse(start_date) - Date.today).to_i/7

  return 0 if current_week < 1
  return 13 if current_week > 12
  current_week
end

def assign_weekly_challenges
  { 1 => [417, 435, 418, 419, 420, 421, 436],
    2 => [426, 427, 428, 429, 430, 425],
    3 => [432, 431, 433, 434],
    4 => [437, 438, 440, 439],
    5 => [441, 442, 444, 55, 443] }
end

def find_phase_zero_challenge_ids
  RequiredChallenge.all.pluck(:challenge_id)
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
cohorts = DBC::Cohort.all

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
users = DBC::User.all

users.each do |u|
  user = User.find_or_initialize_by(socrates_id: u.id)

  user.socrates_id = u.id unless user.socrates_id
  user.cohort_id = u.cohort_id
  user.name = u.name
  user.email = u.email
  user.github = u.profile[:github]
  user.twitter = u.profile[:twitter]
  user.blog_url = u.profile[:blog]
  user.bio = u.profile[:about]
  user.admin = true if u.roles.include?("editor") || u.roles.include?("admin") || u.roles.include?("ta")


  user.save
end

# Seed all exercises
exercises = DBC::Exercise.all

exercises.each do |e|
  exercise = Exercise.find_or_initialize_by(socrates_id: e.id)
  exercise.socrates_id = e.id unless exercise.socrates_id
  exercise.title = e.title
  exercise.save
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

# Seed all exercise attempts

cohorts = Cohort.not_started.not_melt_or_hold

cohorts.each do |cohort|
  cohort.students.each do |student|

    exercise_attempts = DBC::ExerciseAttempt.all(student.socrates_id)

    exercise_attempts.each do |exercise_attempt|

      data = { exercise_id: exercise_attempt.exercise_id,
               user_id: student.socrates_id,
               code: exercise_attempt.code,
               submitted_at: exercise_attempt.created_at }

      found_attempt = ExerciseAttempt.where(exercise_id: exercise_attempt.exercise_id, submitted_at: exercise_attempt.created_at)

      ExerciseAttempt.create(data) if found_attempt.empty?
    end
  end
end

}.to_f/60).to_s + " minutes"
