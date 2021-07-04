class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show, :month, :week, :day]
  before_action :correct_user, only: [:edit, :update]

  def index
    # 経験値順に並び替え(通算)
    total_exp_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      total_exp_count.store(user, User.total_exp(user))
    end
    @total_exp_rank = total_exp_count.sort_by { |_, v| v }.reverse.to_h.keys
    @total_exp_rank = Kaminari.paginate_array(@total_exp_rank).limit(20)
    # 獲得いいね順に並び替え（通算）
    answer_like_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      answer_like_count.store(user, User.answer_like_count(user))
    end
    @answer_likes_rank = answer_like_count.sort_by { |_, v| v }.reverse.to_h.keys
    @answer_likes_rank = Kaminari.paginate_array(@answer_likes_rank).limit(20)
  end

  def month
    # 通算経験値順に並び替え(月間)
    total_exp_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      total_exp_count.store(user, User.time_total_exp(user, Time.current.all_month))
    end
    @month_total_exp_rank = total_exp_count.sort_by { |_, v| v }.reverse.to_h.keys
    @month_total_exp_rank = Kaminari.paginate_array(@month_total_exp_rank).limit(20)
    # 獲得いいね順に並び替え（月間）
    answer_like_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      answer_like_count.store(user, User.time_answer_like_count(user, Time.current.all_month))
    end
    @month_answer_likes_rank = answer_like_count.sort_by { |_, v| v }.reverse.to_h.keys
    @month_answer_likes_rank = Kaminari.paginate_array(@month_answer_likes_rank).limit(20)
  end

  def week
    # 通算経験値順に並び替え(週間)
    total_exp_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      total_exp_count.store(user, User.time_total_exp(user, Time.current.all_week))
    end
    @week_total_exp_rank = total_exp_count.sort_by { |_, v| v }.reverse.to_h.keys
    @week_total_exp_rank = Kaminari.paginate_array(@week_total_exp_rank).limit(20)
    # 獲得いいね順に並び替え（週間）
    answer_like_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      answer_like_count.store(user, User.time_answer_like_count(user, Time.current.all_week))
    end
    @week_answer_likes_rank = answer_like_count.sort_by { |_, v| v }.reverse.to_h.keys
    @week_answer_likes_rank = Kaminari.paginate_array(@week_answer_likes_rank).limit(20)
  end

  def day
    # 通算経験値順に並び替え(日)
    total_exp_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      total_exp_count.store(user, User.time_total_exp(user, Time.current.all_day))
    end
    @day_total_exp_rank = total_exp_count.sort_by { |_, v| v }.reverse.to_h.keys
    @day_total_exp_rank = Kaminari.paginate_array(@day_total_exp_rank).limit(20)
    # 獲得いいね順に並び替え（日）
    answer_like_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      answer_like_count.store(user, User.time_answer_like_count(user, Time.current.all_day))
    end
    @day_answer_likes_rank = answer_like_count.sort_by { |_, v| v }.reverse.to_h.keys
    @day_answer_likes_rank = Kaminari.paginate_array(@day_answer_likes_rank).limit(20)
  end

  def show
    @user = User.find(params[:id])
    @answer_like_count = User.answer_like_count(@user)
    @theme_count = Theme.includes(:user, :answers).where(user_id: @user.id, status: true).count
    # userモデルの経験値計算
    @total_exp = User.total_exp(@user)
    # userモデルの称号の条件式呼び出し
    @total_exp_title = User.total_exp_title(@total_exp)
    # answerだけ表示する
    @new_answers = @user.answers.includes(:user, :theme, :likes).order(created_at: :desc).page(params[:new_page]).per(3)
    @popular_answers = @user.answers.includes(:user, :theme, :likes).sort { |a, b| b.likes.size <=> a.likes.size }
    @popular_answers = Kaminari.paginate_array(@popular_answers).page(params[:popular_page]).per(3)
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

  # current_userでないとデータ変更できない
  def correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user), flash: { alert: '権限がありません' }
    end
  end
end
