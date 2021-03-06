class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :correct_user, only: [:destroy]

  def index
    @new_answers = Answer.includes(:user, :theme, :likes).answer_status?.order(created_at: :desc).page(params[:new_page]).per(5)
    @popular_answers = Answer.includes(:user, :theme, :likes).find(Like.includes(:user, :answer).group(:answer_id).order(Arel.sql('count(answer_id) desc')).pluck(:answer_id))
    @popular_answers = Kaminari.paginate_array(@popular_answers).page(params[:popular_page]).per(5)
    @pick_up_answers = Answer.includes(:user, :theme, :likes).find(Like.includes(:user, :answer).group(:answer_id).where(created_at: Time.current.all_week).order(Arel.sql('count(answer_id) desc')).pluck(:answer_id))
    @pick_up_answers = Kaminari.paginate_array(@pick_up_answers).page(params[:pick_up_page]).per(5)
  end

  def create
    @theme = Theme.find(params[:theme_id])
    @answer = current_user.answers.new(answer_params)
    @answer.theme_id = @theme.id
    if @answer.save
      flash.now[:notice] = '回答を投稿しました'
      # 非同期化のため@answersの値渡す
      @answers = Answer.where(theme_id: @theme.id, status: true).sort { |a, b| b.likes.count <=> a.likes.count }
      render :theme_answers
    else
      render :error
    end
  end

  def destroy
    @answer.destroy
    flash.now[:alert] = '投稿を削除しました'
    # 非同期化のため@theme,@answersの値渡す
    @theme = Theme.find(params[:theme_id])
    @answers = Answer.where(theme_id: @theme.id, status: true).sort { |a, b| b.likes.count <=> a.likes.count }
    render :theme_answers
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end

  # current_userでないとデータ変更できない
  def correct_user
    @answer = Answer.find_by(id: params[:id], theme_id: params[:theme_id])
    unless @answer.user_id == current_user.id
      redirect_to theme_path(@answer.theme_id), flash: { alert: '権限がありません' }
    end
  end
end
