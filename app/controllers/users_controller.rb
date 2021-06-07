class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # @users = User.joins(:answers).where(answers: {created_at: Time.now.all_month}).group(:id).order('count(answers.user_id) desc')
    # @users = User.joins(:answers).where(answers: {created_at: Time.now.all_month}).group(:id).sort {|a,b| b.answers.count <=> a.answers.count}
    @users = User.all.sort{|a,b| b.likes.count <=> a.likes.count}
  end

  def show
    @user = User.find(params[:id])
    @answers = @user.answers
    @answer_like_count = User.answer_like_count(@user)
    @theme_count = Theme.where(user_id: @user.id, status: true).count
    # userモデルの経験値計算
    @total_exp = User.total_exp(@user)
    # userモデルの称号の条件式呼び出し
    @total_exp_title = User.total_exp_title(@total_exp)
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
