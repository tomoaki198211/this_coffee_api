class ChangeCloumnsNotnullAddReviews3 < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :setting, :boolean, default: false, null: false
  end
end
