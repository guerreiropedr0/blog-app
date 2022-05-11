require 'rails_helper'

RSpec.describe 'Users', type: :system do
  context 'index page' do
    before(:each) do
      @user = User.create(name: 'Pedro Guerreiro', photo: 'https://i.pravatar.cc/150?img=12',
                          bio: 'I\'m creating a test right now!',
                          email: 'test@domain.com')
      @user.confirm
      visit users_path
    end

    it 'should show welcoming message' do
      expect(page).to have_content('Welcome to Blog App')
    end

    it 'should show username of user/users' do
      expect(page).to have_content('Pedro Guerreiro')
    end

    it 'should show image of user/users' do
      expect(page).to have_css("img[src*='i.pravatar.cc/150?img=12']")
    end

    it 'should show number of posts of user/users' do
      expect(page).to have_content('Number of posts 0')
    end

    it 'should click open profile button and redirect to that user\'s show page' do
      click_link('Open Profile')
      expect(current_path).to eql(user_path(@user.id))
    end
  end
end
