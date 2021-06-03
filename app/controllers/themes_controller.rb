class ThemesController < ApplicationController
  def new
    @theme = Theme.new
    @themes = current_user.themes
  end

  def create
    @theme = Theme.new(theme_params)
    @theme.user_id = current_user.id
    if @theme.save
      flash[:notice] = 'お題を提案しました'
      redirect_back(fallback_location: new_theme_path)
    else
      @themes = current_user.themes
      render :new
    end
  end

  def index
    @themes = Theme.all.order(created_at: :desc)
  end

  def show
    @theme = Theme.find(params[:id])
  end

  def destroy
    @theme = Theme.find(params[:id])
    @theme.destroy
    redirect_to new_theme_path
  end

  private

  def theme_params
    params.require(:theme).permit(:image, :content)
  end
end
