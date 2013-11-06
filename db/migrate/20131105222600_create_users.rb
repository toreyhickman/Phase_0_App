class CreateUsers < ActiveRecord::Migration
  def change
    create_table    :users, id: false do |t|
      t.primary_key :socrates_id
      t.integer     :cohort_id
      t.string      :name
      t.string      :email
      t.string      :github
      t.string      :twitter
      t.string      :blog_url
      t.text        :bio
      t.boolean     :intellectual_flag, default: false
      t.boolean     :cultural_flag, default: false

      t.timestamps
    end

    add_index :users, :cohort_id
  end
end
