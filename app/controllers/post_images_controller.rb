class PostImagesController < ApplicationController
  before_action :authenticate_user!

  def new
    @post_image = PostImage.new
  end

  def index
  	@post_images = PostImage.all
    # @user.name = User.all
  end

  def create
  	@post_image = PostImage.new(post_image_params)
  	@post_image.user_id = current_user.id
  	@post_image.save
  	redirect_to root_path
  end

  def show
    @post_image = PostImage.find(params[:id])
  end

  def destroy
    @post_image = PostImage.find(params[:id])
    post_image.destroy
    redirect_to root_path
  end

  private
  def post_image_params
  	params.require(:post_image).permit(:title, :body, :image)
  end

end
