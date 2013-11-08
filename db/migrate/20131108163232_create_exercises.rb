class CreateExercises < ActiveRecord::Migration
  def change
    create_table    :exercises, id: false do |t|
      t.primary_key :socrates_id
      t.string      :title
    end
  end
end
