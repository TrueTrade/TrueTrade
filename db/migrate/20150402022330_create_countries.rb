class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries, id: false do |t|
      t.primary_key :code
      t.string :name
      t.string :continent
      t.timestamps
    end
  end
end
