class HomesController < ApplicationController

  def top
    # theme
    @new_themes = Theme.all.theme_status?.order(updated_at: :desc).limit(6)
    # 回答数の多いお題（週間）
    now = Time.current
    @pick_up_themes = Theme.find(Answer.group(:theme_id).where(created_at: now.all_week).order('count(theme_id) desc').limit(6).pluck(:theme_id))

    # user
    # 管理者以外経験値順に並び替え
    total_exp_count = {}
    User.where(admin: false).each do |user|
      total_exp_count.store(user , User.total_exp(user))
    end
    @total_exp_rank = total_exp_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @total_exp_rank = Kaminari.paginate_array(@total_exp_rank).limit(10)
    # 管理者以外獲得いいね順に並び替え
    answer_like_count = {}
    User.where(admin: false).each do |user|
      answer_like_count.store(user , User.answer_like_count(user))
    end
    @answer_likes_rank = answer_like_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @answer_likes_rank = Kaminari.paginate_array(@answer_likes_rank).limit(10)

    # answer
    @new_answers = Answer.all.answer_status?.order(created_at: :desc).limit(3)
    # いいねの多い回答（週間）
    @pick_up_answers = Answer.pick_up_answers
  end

  def guide
  end
end
