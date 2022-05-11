require 'rails_helper'

RSpec.describe 'posts/index.html.erb', type: :system do
  before(:each) do
    @user = User.create(name: 'Pedro Guerreiro', photo: 'https://i.pravatar.cc/150?img=12',
                        bio: 'I\'m creating a test right now!',
                        email: 'test@domain.com')
    @user.confirm

    Post.create(author_id: @user.id, title: 'Should not appear', text: 'It\'s exciting!')
    Post.create(author_id: @user.id, title: 'Capybara Rules', text: 'It\'s exciting!')
    Post.create(author_id: @user.id, title: 'RSpec is cool', text: 'It\'s exciting!')
    @first_post = Post.create(author_id: @user.id, title: 'Integration test', text: 'It\'s exciting!')

    Comment.create(author_id: @user.id, post_id: @first_post.id, text: 'test comment')
    Like.create(author_id: @user.id, post_id: @first_post.id)

    visit user_posts_path(@user.id)
  end

  it "I can see the user's profile picture." do
    expect(page).to have_css("img[src*='i.pravatar.cc/150?img=12']")
  end

  it "I can see the user's username." do
    expect(page).to have_content("Pedro Guerreiro")
  end
  
  it "I can see the number of posts the user has written." do
    expect(page).to have_content("Number of posts 4")
  end

  it "I can see a post's title." do
    expect(page).to have_content("Integration test")
  end

  it "I can see some of the post's body." do
    expect(page).to have_content("It's exciting!")
  end

  it "I can see the first comments on a post." do
    expect(page).to have_content("test comment")
  end

  it "I can see how many comments a post has." do
    expect(page).to have_content("Comments 1")
  end

  it "I can see how many likes a post has." do
    expect(page).to have_content("Likes 0")
  end

  it "I can see a section for pagination if there are more posts than fit on the view." do
    expect(page).to have_content("Pagination")
  end

  it "When I click on a post, it redirects me to that post's show page." do
    click_link('See post')
    expect(current_path).to eql(user_post_path(@user, @first_post.id))
  end
end
