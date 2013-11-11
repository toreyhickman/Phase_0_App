class AddIndecesToRequiredChallenges < ActiveRecord::Migration
  def change
    add_index :required_challenges, :week_id
    add_index :required_challenges, :challenge_id
  end
end
