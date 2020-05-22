class HomesController < ApplicationController

	def top#Top画面に新着6枚を表示する設定
		@post_images = PostImage.page(params[:page]).per(6).order("created_at DESC")
	end
end
