class CreateCommodities < ActiveRecord::Migration
  def change
    create_table :commodities, id: false do |t|
      t.primary_key :code
      t.string :name
      t.timestamps
    end
  end
end