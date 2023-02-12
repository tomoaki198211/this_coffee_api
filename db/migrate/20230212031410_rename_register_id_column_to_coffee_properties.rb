class RenameRegisterIdColumnToCoffeeProperties < ActiveRecord::Migration[6.1]
  def change
    rename_column :coffee_properties, :register_id, :register_code
  end
end
