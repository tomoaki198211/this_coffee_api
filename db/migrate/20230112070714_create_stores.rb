class CreateStores < ActiveRecord::Migration[6.1]
  def change
    create_table :stores do |t|
      t.string :name, :null => false
      t.timestamp :created_at
    end
  end
end
