class ChangeDataRegisterIdToCoffeeProperties < ActiveRecord::Migration[6.1]
  def change
    change_column :coffee_properties, :register_id, :string
  end
end
