class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  def increment_counter
    post = Post.find_by(id: post_id)
    if post.comments_counter
      post.update(comments_counter: post.comments_counter + 1)
    else
      post.update(comments_counter: 1)
    end
  end
end
