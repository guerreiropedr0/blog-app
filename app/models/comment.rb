class Comment < ApplicationRecord
  belongs_to :author, class_name: 'User'
  belongs_to :post

  after_save :increment_comment_counter

  def increment_comment_counter
    post = Post.find_by(id: post_id)
    if post.comments_counter
      post.update(comments_counter: post.comments_counter + 1)
    else
      post.update(comments_counter: 1)
    end
  end
end
