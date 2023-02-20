class ChangeCloumnsNotnullAddReviews2 < ActiveRecord::Migration[6.1]
  def change
    change_column :reviews, :setting, :boolean, null: false
  end
end
