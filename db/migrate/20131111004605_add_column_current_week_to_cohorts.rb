class AddColumnCurrentWeekToCohorts < ActiveRecord::Migration
  def change
    add_column :cohorts, :current_week, :integer
  end
end
