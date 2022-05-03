class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
  end

  def show; end
end
