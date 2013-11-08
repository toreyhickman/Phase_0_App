class CreateExerciseAttempts < ActiveRecord::Migration
  def change
    create_table :exercise_attempts do |t|
      t.integer  :exercise_id
      t.integer  :user_id
      t.text     :code
      t.datetime :submitted_at
    end

    add_index :exercise_attempts, :exercise_id
    add_index :exercise_attempts, :user_id
  end
end
