class HomesController < ApplicationController

  def top
    @user = User.new
    # theme
    @new_themes = Theme.includes(:user, :answers).theme_status?.order(updated_at: :desc).limit(6)
    # 今月の回答数の多いお題
    @pick_up_themes = Theme.pick_up_themes

    # user
    # 管理者以外経験値順に並び替え
    total_exp_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      total_exp_count.store(user , User.total_exp(user))
    end
    @total_exp_rank = total_exp_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @total_exp_rank = Kaminari.paginate_array(@total_exp_rank).limit(10)
    # 管理者以外獲得いいね順に並び替え
    answer_like_count = {}
    User.includes(:themes, :answers, :likes).where(admin: false).each do |user|
      answer_like_count.store(user , User.answer_like_count(user))
    end
    @answer_likes_rank = answer_like_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @answer_likes_rank = Kaminari.paginate_array(@answer_likes_rank).limit(10)

    # answer
    @new_answers = Answer.includes(:user, :theme, :likes).answer_status?.order(created_at: :desc).limit(3)
    # 今月のいいね数の多い回答
    @pick_up_answers = Answer.pick_up_answers
  end

  def guide
  end
end
