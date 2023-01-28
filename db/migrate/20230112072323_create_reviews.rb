class CreateReviews < ActiveRecord::Migration[6.1]
  def change
    create_table :reviews do |t|
      t.references :user, null: false, foreign_key: true
      t.references :coffee, null: false, foreign_key: true
      t.integer :intuition
      t.integer :efficiency
      t.integer :flavor
      t.integer :sweetness
      t.integer :rich
      t.integer :acidity
      t.integer :bitter
      t.text :remarks
      t.boolean :setting

      t.timestamps
    end
  end
end
