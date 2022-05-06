class LikesController < ApplicationController
  def new
    @like = Like.new
  end

  def create
    @like = Like.new(author_id: current_user.id, post_id: params[:post_id])

    redirect_to root_path, notice: 'Successfully liked.' if @like.save
  end
end
