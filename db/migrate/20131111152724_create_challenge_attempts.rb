class CreateChallengeAttempts < ActiveRecord::Migration
  def change
    create_table :challenge_attempts do |t|
      t.integer  :challenge_id
      t.integer  :user_id
      t.string   :repo
      t.datetime :submitted_at
    end

    add_index :challenge_attempts, :challenge_id
    add_index :challenge_attempts, :user_id
  end
end
