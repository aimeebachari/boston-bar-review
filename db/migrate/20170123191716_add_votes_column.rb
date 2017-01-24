class AddVotesColumn < ActiveRecord::Migration[5.0]
  def change
    add_column :reviews, :up_votes, :integer, default: 0
    add_column :reviews, :down_votes, :integer, default: 0
  end
end
