class AddPostRefToLikes < ActiveRecord::Migration[7.0]
  def change
    add_foreign_key :likes, :posts, column: :post_id, primary_key: :id
    add_index :likes, :post_id
  end
end
