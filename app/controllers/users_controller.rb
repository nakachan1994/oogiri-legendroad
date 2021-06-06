class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @answers = @user.answers
    @answer_like_count = Like.where(answer_id: Answer.where(user_id: @user.id).pluck(:id)).count * 10
    @theme_count = Theme.where(user_id: @user.id, status: true).count * 10
    @total_exp = @answer_like_count + @theme_count
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to user_path(@user), notice: '変更しました'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :profile_image, :email)
  end
end
