class CreateWeeks < ActiveRecord::Migration
  def change
    create_table :weeks do |t|
      t.string   :name
    end
  end
end
