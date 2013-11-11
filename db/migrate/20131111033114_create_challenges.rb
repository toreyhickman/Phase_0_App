class CreateChallenges < ActiveRecord::Migration
  def change
    create_table :challenges, id: false do |t|
      t.primary_key :socrates_id
      t.string      :name
    end
  end
end
