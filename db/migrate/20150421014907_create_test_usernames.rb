class CreateTestUsernames < ActiveRecord::Migration
  def change
    create_table :test_usernames do |t|
      t.string :name
      t.text :description
      t.string :picture

      t.timestamps
    end
  end
end
