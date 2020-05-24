class RelationshipsController < ApplicationController

	def follow
		current_user.follow(params[:id])
		redirect_back(fallback_location: root_path)
		# redirect_to user_path(@user)
		# redirect_to request.referer
	end

	def unfollow
		current_user.unfollow(params[:id])
		redirect_back(fallback_location: root_path)
	end
end
