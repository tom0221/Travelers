class UsersController < ApplicationController

	def create
	end

  def show
  	@user = User.find(params[:id])
  end

  def edit
  	@user = User.find(params[:id])
  end

  def update
  	@user = User.find(params[:id])
    @user.update(user_params)
  	redirect_to user_path(@user)
  end

  def bye_confirm#退会確認ページ
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_thanks_path
  end

  # def thanks
  # end

  private#以下変更を許可する
  def user_params
  	params.require(:user).permit(:name, :email, :password, :profile_image)
	end

end
