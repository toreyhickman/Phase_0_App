class User < ActiveRecord::Base
  include Gravtastic
  gravtastic secure: true, filetype: :jpg, size: 100#, default: "https://secure.gravatar.com/avatar/de91aca465cb595e94fe2c1d60bb2ae8.png?r=PG&d=mm&s=100"


  belongs_to :cohort

  has_many :exercise_attempts
  has_many :attempted_exercises, through: :exercise_attempts, source: :exercise

  has_many :challenge_attempts
  has_many :attempted_challenges, through: :challenge_attempts, source: :challenge
end
