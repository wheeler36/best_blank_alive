class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorized_user, only: [:destroy]
  before_action :find_comment, only: [:show, :destroy]

  def show
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = Comment.create(comment_params)
    @comment.user_id = current_user.id
    @comment.post_id = @post.id

    if @comment.save
      redirect_to post_path(@post)
    else
      render 'new'
    end
  end

  def destroy
    @comment.destroy
    redirect_to post_path
  end

  private

  def find_comment
    @comment = Comment.find(params[:id])
  end

  def authorized_user
    @comment = current_user.comments.find_by(id: params[:id])
    redirect_to root_path, notice: "No soup for you!" if @comment.nil?
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
