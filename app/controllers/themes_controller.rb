class ThemesController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def new
    @theme = Theme.new
    @themes = current_user.themes.order(created_at: :desc)
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
    @themes = Theme.all.theme_status?.order(updated_at: :desc).page(params[:page]).per(5)
  end

  def show
    @theme = Theme.find(params[:id])
    @answers = Answer.where(theme_id: @theme.id, status: true).sort{|a,b| b.likes.count <=> a.likes.count}
    @answer = Answer.new
    @total_exp_title = User.total_exp_title(User.total_exp(@theme.user))
  end

  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy
    flash.now[:alert] = 'お題を削除しました'
    @themes = current_user.themes.order(created_at: :desc)
    render :post_themes
  end

  private

  def theme_params
    params.require(:theme).permit(:image, :content)
  end
end
