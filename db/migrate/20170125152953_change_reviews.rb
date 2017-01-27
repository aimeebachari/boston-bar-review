class ChangeReviews < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :up_votes, :integer, default: 0
    remove_column :reviews, :down_votes, :integer, default: 0
    add_column :reviews, :votes, :integer, default: 0
  end
end
