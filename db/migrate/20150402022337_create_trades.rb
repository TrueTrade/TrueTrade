class CreateTrades < ActiveRecord::Migration
  def change
    create_table :trades do |t|
      t.integer :year
      t.integer :exporter_code
      t.integer :importer_code
      t.integer :commodity_code
      t.float :volume

      t.timestamps
    end
  end
end
