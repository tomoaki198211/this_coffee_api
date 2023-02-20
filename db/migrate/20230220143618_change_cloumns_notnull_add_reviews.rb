class ChangeCloumnsNotnullAddReviews < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :intuition, :integer, null: false
    change_column :reviews, :efficiency, :integer, null: false
    change_column :reviews, :remarks, :text, null: false
  end
end
