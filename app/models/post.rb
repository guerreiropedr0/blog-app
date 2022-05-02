class Post < ApplicationRecord
  has_many :likes
  has_many :comments
  belongs_to :author, class_name: 'User'

  def increment_counter
    user = User.find_by(id: author_id)
    if user.posts_counter
      user.update(posts_counter: user.posts_counter + 1)
    else
      user.update(posts_counter: 1)
    end
  end

  def recent_comments
    Comment.where(post_id: id).limit(5)
  end
end
