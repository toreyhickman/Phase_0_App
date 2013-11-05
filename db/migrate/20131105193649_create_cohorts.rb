class CreateCohorts < ActiveRecord::Migration
  def change
    create_table :cohorts do |t|
      t.integer  :socrates_id
      t.text     :name
      t.text     :email
      t.text     :location
      t.datetime :start_date
      t.boolean  :in_session

      t.timestamps
    end
  end
end
