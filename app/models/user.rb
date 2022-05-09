class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, foreign_key: 'author_id'
  has_many :comments
  has_many :likes

  validates :name, length: { minimum: 1 }
  validates :posts_counter, numericality: { greater_than_or_equal_to: 0 }

  def recent_posts
    posts.order('created_at Desc').limit(3)
  end
end
