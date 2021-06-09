class AnswersController < ApplicationController
  before_action :authenticate_user!, except: [:index]

  def index
    @answers = Answer.all.answer_status?.order(created_at: :desc)
  end

  def create
    @theme = Theme.find(params[:theme_id])
    @answer = current_user.answers.new(answer_params)
    @answer.theme_id = @theme.id
    if @answer.save
      redirect_to theme_path(@theme), notice: '投稿しました'
    else
      render 'themes/show'
    end
  end

  def destroy
    Answer.find_by(id: params[:id], theme_id: params[:theme_id]).destroy
    flash[:alert] = '投稿を削除しました'
    redirect_back(fallback_location: root_path)
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
