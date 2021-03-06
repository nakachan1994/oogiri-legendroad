class ThemesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :correct_user, only: [:destroy]

  def new
    @theme = Theme.new
    @themes = current_user.themes.includes(:user, :answers).order(created_at: :desc)
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user_id = current_user.id
    if @theme.save
      flash.now[:notice] = 'お題を提案しました'
      @themes = current_user.themes.order(created_at: :desc)
      render :post_themes
    else
      @themes = current_user.themes.order(created_at: :desc)
      render :error
    end
  end

  def index
    @new_themes = Theme.includes(:user, :answers).theme_status?.order(updated_at: :desc).page(params[:new_page]).per(5)
    @popular_themes = Theme.find(Answer.group(:theme_id).order(Arel.sql('count(theme_id) desc')).pluck(:theme_id))
    @popular_themes = Kaminari.paginate_array(@popular_themes).page(params[:popular_page]).per(5)
    @pick_up_themes = Theme.find(Answer.group(:theme_id).where(created_at: Time.current.all_week).order(Arel.sql('count(theme_id) desc')).pluck(:theme_id))
    @pick_up_themes = Kaminari.paginate_array(@pick_up_themes).page(params[:pick_up_page]).per(5)
  end

  def show
    @theme = Theme.find(params[:id])
    @answers = Answer.includes(:user, :theme, :likes).where(theme_id: @theme.id, status: true).sort { |a, b| b.likes.size <=> a.likes.size }
    @answer = Answer.new
    @total_exp_title = User.total_exp_title(User.total_exp(@theme.user))
  end

  def destroy
    # @theme = Theme.find(params[:id])
    @theme.destroy
    flash.now[:alert] = 'お題を削除しました'
    @themes = current_user.themes.order(created_at: :desc)
    render :post_themes
  end

  private

  def theme_params
    params.require(:theme).permit(:image, :content)
  end

  # current_userでないとデータ変更できない
  def correct_user
    @theme = Theme.find(params[:id])
    unless @theme.user_id == current_user.id
      redirect_to new_theme_path, flash: { alert: '権限がありません' }
    end
  end
end
