require 'rails_helper'

RSpec.describe 'Devise sessions', type: :system do
  context 'login page' do
    before(:each) do
      @user = User.create(name: 'Pedro Guerreiro', photo: 'https://i.pravatar.cc/150?img=12',
                          bio: 'I\'m creating a test right now!',
                          email: 'test@domain.com',
                          password: '123456', password_confirmation: '123456')
      @user.confirm

      visit new_user_session_path
    end

    it 'should show username input' do
      expect(page).to have_field('Email')
    end

    it 'should show password input' do
      expect(page).to have_field('Password')
    end

    it 'should throw error when clicking submit button without filling form' do
      click_button('Log in')
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'should throw error when clicking submit button when filling form with incorrect data' do
      fill_in('Email', with: 'p@gmail.com')
      fill_in('Password', with: '123456')
      click_button('Log in')
      expect(page).to have_content('Invalid Email or password.')
    end

    it 'should redirect to root path when data is correct and submit button is clicked' do
      fill_in('Email', with: 'test@domain.com')
      fill_in('Password', with: '123456')
      click_button('Log in')
      expect(current_path).to eql(root_path)
    end
  end
end
