class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :authorized_user, only: [:edit, :update, :destroy]
  before_action :find_post, only: [:show, :edit, :update, :destroy, :upvote, :downvote]

  def index
    @posts = Post.all.order("created_at DESC").paginate(page: params[:page], per_page: 5)
  end

  def show
    @comments = Comment.where(post_id: @post)
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)

    if @post.save
      redirect_to @post, notice: "Success! You created your post!"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: "Success! Update complete!"
    else
      render 'edit'
    end
  end

  def destroy
    @post.destroy
    redirect_to root_path
  end

  def upvote
    @post.upvote_by current_user
    redirect_to :back
  end

  def downvote
    @post.downvote_by current_user
    redirect_to :back
  end

  private

  def find_post
    @post = Post.find(params[:id])
  end

  def authorized_user
    @post = current_user.posts.find_by(id: params[:id])
    redirect_to root_path, notice: "No soup for you!" if @post.nil?
  end

  def post_params
    params.require(:post).permit(:title, :content, :choice)
  end
end
