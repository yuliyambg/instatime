class PostsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  def new
    @post = Post.new
  end

  def index

    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def create
    # byebug
    @post = Post.new(permit_post)
    if @post.save
      if params[:images]
        params[:images].each { |image|
          @post.images.create(image: image, is_public: params[:is_public])
        }
      end

      flash[:success] = "Success!"
      redirect_to post_path(@post)
    else
      flash[:error] = @post.errors.full_messages
      redirect_to new_post_path
    end
  end
  private

  def permit_post
    params.require(:post).permit(:images, :description)
  end
end
