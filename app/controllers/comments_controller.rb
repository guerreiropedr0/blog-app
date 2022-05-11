class CommentsController < ApplicationController
  load_and_authorize_resource

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.author = current_user
    @comment.post_id = params[:post_id]

    if @comment.save
      redirect_to root_path, notice: 'Successfully created comment.'
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find_by(id: params[:id])

    if @comment.destroy
      redirect_to root_path, notice: 'Successfuly deleted comment.'
    else
      render :new
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text)
  end
end
