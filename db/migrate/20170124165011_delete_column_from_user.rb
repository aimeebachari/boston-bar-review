class DeleteColumnFromUser < ActiveRecord::Migration[5.0]
  def change
    remove_column :users, :avatar_url, :string, default: ""
  end
end
