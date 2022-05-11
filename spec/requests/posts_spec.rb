require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example) do
      @user = User.create(name: 'Pedro Guerreiro', photo: 'random_link.png', bio: 'I\'m creating a test right now!')
      @user.confirm
      get user_posts_path(@user.id)
    end

    it 'should return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render template' do
      expect(response).to render_template(:index)
    end

    it 'should render placeholder text' do
      expect(response.body).to include 'Pagination'
    end
  end

  describe 'GET /show' do
    before(:example) do
      @user = User.create(name: 'Pedro Guerreiro', photo: 'random_link.png', bio: 'I\'m creating a test right now!')
      @user.confirm
      @post = Post.create(author_id: @user.id, title: 'Controller Spec', text: 'It\'s exciting!')
      get user_post_path(@user.id, @post.id)
    end

    it 'should return http success' do
      expect(response).to have_http_status(:success)
    end

    it 'should render template' do
      expect(response).to render_template(:show)
    end

    it 'should render placeholder text' do
      expect(response.body).to include 'Add a comment'
    end
  end
end
