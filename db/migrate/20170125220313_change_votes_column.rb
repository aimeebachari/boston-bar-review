class ChangeVotesColumn < ActiveRecord::Migration[5.0]
  def change
    remove_column :reviews, :votes
    add_column :reviews, :score, :integer, default: 0
  end
end
