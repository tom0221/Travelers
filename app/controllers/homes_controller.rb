class HomesController < ApplicationController

	def top
		@post_images = PostImage.all
	end
end
