class RequiredChallenge < ActiveRecord::Base
  belongs_to :week
  belongs_to :challenge
end
