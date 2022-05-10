class PostsController < ApplicationController
  load_and_authorize_resource

  def index
    @user = User.find(params[:user_id])
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.author = current_user

    if @post.save
      redirect_to root_path, notice: 'Successfully created post.'
    else
      render :new
    end
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    if @post.destroy
      redirect_to root_path, notice: 'Successfuly deleted post.'
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :text)
  end
end
