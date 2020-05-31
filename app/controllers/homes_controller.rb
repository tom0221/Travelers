class HomesController < ApplicationController

	def top#Top画面に新着6枚を表示する設定
		# @users = User.all
		@post_images = PostImage.page(params[:page]).per(6).order("created_at DESC")
	end

	def search
	    if params[:name].present?
	      @users = User.where('name LIKE ?', "%#{params[:name]}%")
	    else
	      @users = User.none
	    end
  	end

	# def top
	# 	@post_images = ["post_image1", "post_image2", "post_image3", "post_image4", "post_image5",
	# 	 "post_image6"]
	# end
end
