class AddnoteTocoffeeProperties < ActiveRecord::Migration[6.1]
  def change
    add_column :coffee_properties, :note, :text
  end
end
