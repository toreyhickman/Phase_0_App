class CreateRequiredChallenges < ActiveRecord::Migration
  def change
    create_table :required_challenges, id: false do |t|
      t.integer  :week_id
      t.integer  :challenge_id
    end
  end
end
