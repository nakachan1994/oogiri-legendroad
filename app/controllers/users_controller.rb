class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # 管理者以外経験値順に並び替え
    total_exp_count = {}
    User.where(admin: false).each do |user|
      total_exp_count.store(user , User.total_exp(user))
    end
    @total_exp_rank = total_exp_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @total_exp_rank = Kaminari.paginate_array(@total_exp_rank).limit(20)
    # 管理者以外獲得いいね順に並び替え
    answer_like_count = {}
    User.where(admin: false).each do |user|
      answer_like_count.store(user , User.answer_like_count(user))
    end
    @answer_likes_rank = answer_like_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @answer_likes_rank = Kaminari.paginate_array(@answer_likes_rank).limit(20)
  end

  def show
    @user = User.find(params[:id])
    @answers = @user.answers.order(created_at: :desc).page(params[:page]).per(3)
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
