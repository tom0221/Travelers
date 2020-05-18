class HomesController < ApplicationController

	def top
		@post_image = PostImage.all
	end
end
