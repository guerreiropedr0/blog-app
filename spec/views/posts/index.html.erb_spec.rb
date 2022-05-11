require 'rails_helper'

RSpec.describe 'post', type: :system do
  context 'index page' do
    before(:each) do
      @user = User.create(name: 'Pedro Guerreiro', photo: 'https://i.pravatar.cc/150?img=12',
                          bio: 'I\'m creating a test right now!',
                          email: 'test@domain.com')
      @user.confirm

      visit user_posts_path(@user.id)
    end

    it "I can see the user's profile picture." do
      expect(page).to have_css("img[src*='i.pravatar.cc/150?img=12']")
    end

    it "I can see the user's username." do
      expect(page).to have_content('Pedro Guerreiro')
    end
  end

  context 'index page with post' do
    before(:each) do
      @user = User.create(name: 'Pedro Guerreiro', photo: 'https://i.pravatar.cc/150?img=12',
                          bio: 'I\'m creating a test right now!',
                          email: 'test@domain.com')
      @user.confirm

      @post = Post.create(author_id: @user.id, title: 'Integration test', text: 'It\'s exciting!')
      Comment.create(author_id: @user.id, post_id: @post.id, text: 'Test Comment')
      Like.create(author_id: @user.id, post_id: @post.id)

      visit user_posts_path(@user.id)
    end

    it 'I can see the number of posts the user has written.' do
      expect(page).to have_content('Number of posts 1')
    end

    it "I can see a post's title." do
      expect(page).to have_content('Integration test')
    end

    it "I can see some of the post's body." do
      expect(page).to have_content("It's exciting!")
    end

    it 'I can see the first comments on a post.' do
      expect(page).to have_content('Test Comment')
    end

    it 'I can see how many comments a post has.' do
      expect(page).to have_content('Comments 1')
    end

    it 'I can see how many likes a post has.' do
      expect(page).to have_content('Likes 1')
    end
  end

  context 'index page post redirect and pagination' do
    before(:each) do
      @user = User.create(name: 'Pedro Guerreiro', photo: 'https://i.pravatar.cc/150?img=12',
                          bio: 'I\'m creating a test right now!',
                          email: 'test@domain.com')
      @user.confirm

      @post = Post.create(author_id: @user.id, title: 'Integration test', text: 'It\'s exciting!')

      visit user_posts_path(@user.id)
    end
    it 'I can see a section for pagination if there are more posts than fit on the view.' do
      expect(page).to have_content('Pagination')
    end

    it "When I click on a post, it redirects me to that post's show page." do
      click_link(@post.title)
      expect(current_path).to eql(user_post_path(@user.id, @post.id))
    end
  end
end
