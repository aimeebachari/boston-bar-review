class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.belongs_to :user
      t.belongs_to :bar
      t.text :body
      t.integer :rating, null: false

      t.timestamps
    end
  end
end
