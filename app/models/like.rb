class Like < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :increment_like_counter

  def increment_like_counter
    post = Post.find_by(id: post_id)
    if post.likes_counter
      post.update(likes_counter: post.likes_counter + 1)
    else
      post.update(likes_counter: 1)
    end
  end
end
