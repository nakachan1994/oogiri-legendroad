class HomesController < ApplicationController

  def top
    @themes = Theme.all.theme_status?.order(updated_at: :desc).limit(3)
    # 経験値順に並び替え
    total_exp_count = {}
    User.where(admin: false).each do |user|
      total_exp_count.store(user , User.total_exp(user))
    end
    @total_exp_rank = total_exp_count.sort_by{ |_,v| v}.reverse.to_h.keys
    @total_exp_rank = Kaminari.paginate_array(@total_exp_rank).page(params[:page]).per(10)
  end

  def guide
  end
end
