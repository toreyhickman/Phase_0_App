class Week < ActiveRecord::Base
  has_many :required_challenges
  has_many :challenges, through: :required_challenges
end
