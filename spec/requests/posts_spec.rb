require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  describe 'GET /index' do
    before(:example) { get '/users/:user_id/posts' }

    it('should respond with a successful http status') do
      expect(response).to have_http_status(:ok)
    end

    it('should render appropriate template') do
      expect(response).to render_template(:index)
    end

    it('should include correct placeholder text') do
      expect(response.body).to include 'Here is a list of posts for a given user'
    end
  end

  describe 'GET /show' do
    before(:example) { get '/users/:user_id/posts/:id' }

    it('should respond with a successful http status') do
      expect(response).to have_http_status(:ok)
    end

    it('should render appropriate template') do
      expect(response).to render_template(:show)
    end

    it('should include correct placeholder text') do
      expect(response.body).to include 'Here is a specific post for a given user'
    end
  end
end
