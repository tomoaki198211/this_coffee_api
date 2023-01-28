class CreateCoffeeProperties < ActiveRecord::Migration[6.1]
  def change
    create_table :coffee_properties do |t|
      t.string :name, :null => false
      t.string :size
      t.integer :price
      t.integer :capacity
      t.string :image
      t.references :store, null: false, foreign_key: true

      t.timestamps
    end
  end
end
