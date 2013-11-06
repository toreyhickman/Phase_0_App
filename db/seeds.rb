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
  user.bio = u.bio
  user.admin = true if u.roles.include?("editor") || u.roles.include?("admin") || u.roles.include?("ta")


  user.save
end
