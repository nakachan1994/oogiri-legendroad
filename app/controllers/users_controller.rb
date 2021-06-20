class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # 経験値順に並び替え(通算)
    total_exp_count = {}
    User.where(admin: false).each do |user|
      total_exp_count.store(user , User.total_exp(user))
    end
    @total_exp_rank = total_exp_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @total_exp_rank = Kaminari.paginate_array(@total_exp_rank).limit(20)
    # 通算経験値順に並び替え(月間)
    total_exp_count = {}
    User.where(admin: false).each do |user|
      total_exp_count.store(user , User.month_total_exp(user))
    end
    @month_total_exp_rank = total_exp_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @month_total_exp_rank = Kaminari.paginate_array(@month_total_exp_rank).limit(20)
    # 通算経験値順に並び替え(週間)
    total_exp_count = {}
    User.where(admin: false).each do |user|
      total_exp_count.store(user , User.week_total_exp(user))
    end
    @week_total_exp_rank = total_exp_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @week_total_exp_rank = Kaminari.paginate_array(@week_total_exp_rank).limit(20)
    # 通算経験値順に並び替え(日)
    total_exp_count = {}
    User.where(admin: false).each do |user|
      total_exp_count.store(user , User.day_total_exp(user))
    end
    @day_total_exp_rank = total_exp_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @day_total_exp_rank = Kaminari.paginate_array(@day_total_exp_rank).limit(20)

    # 獲得いいね順に並び替え（通算）
    answer_like_count = {}
    User.where(admin: false).each do |user|
      answer_like_count.store(user , User.answer_like_count(user))
    end
    @answer_likes_rank = answer_like_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @answer_likes_rank = Kaminari.paginate_array(@answer_likes_rank).limit(20)
    # 獲得いいね順に並び替え（月間）
    answer_like_count = {}
    User.where(admin: false).each do |user|
      answer_like_count.store(user , User.month_answer_like_count(user))
    end
    @month_answer_likes_rank = answer_like_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @month_answer_likes_rank = Kaminari.paginate_array(@month_answer_likes_rank).limit(20)
    # 獲得いいね順に並び替え（週間）
    answer_like_count = {}
    User.where(admin: false).each do |user|
      answer_like_count.store(user , User.week_answer_like_count(user))
    end
    @week_answer_likes_rank = answer_like_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @week_answer_likes_rank = Kaminari.paginate_array(@week_answer_likes_rank).limit(20)
    # 獲得いいね順に並び替え（日）
    answer_like_count = {}
    User.where(admin: false).each do |user|
      answer_like_count.store(user , User.day_answer_like_count(user))
    end
    @day_answer_likes_rank = answer_like_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @day_answer_likes_rank = Kaminari.paginate_array(@day_answer_likes_rank).limit(20)
  end

  def show
    @user = User.find(params[:id])
    @answer_like_count = User.answer_like_count(@user)
    @theme_count = Theme.where(user_id: @user.id, status: true).count
    # userモデルの経験値計算
    @total_exp = User.total_exp(@user)
    # userモデルの称号の条件式呼び出し
    @total_exp_title = User.total_exp_title(@total_exp)
    # answerだけ表示する
    @new_answers = @user.answers.order(created_at: :desc).page(params[:new_page]).per(3)
    @popular_answers = Answer.where(user_id: @user.id).sort{|a,b| b.likes.count <=> a.likes.count}
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
end
