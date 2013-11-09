require 'benchmark'
puts (Benchmark.realtime {

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
