class Challenge < ActiveRecord::Base
  has_many :weekly_assignments, class_name: "RequiredChallenge"
  has_many :weeks_assigned_to, through: :weekly_assignments, source: :week

end
