class RenameCapacityColumnToCoffeeProperties < ActiveRecord::Migration[6.1]
  def change
    rename_column :coffee_properties, :capacity, :register_id
  end
end
