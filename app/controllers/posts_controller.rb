class PostsController < ApplicationController
  def index
    @user = User.find_by(id: params[:user_id])
  end

  def show
    @post = Post.find_by(id: params[:id])
  end

  def new; end

  def create; end
end
