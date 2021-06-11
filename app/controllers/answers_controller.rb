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
      flash[:notice] = '回答を投稿しました'
      # 非同期化のため@answersの値渡す
      @answers = Answer.where(theme_id: @theme.id, status: true).sort{|a,b| b.likes.count <=> a.likes.count}
      render :theme_answers
    else
      render 'themes/show'
    end
  end

  def destroy
    Answer.find_by(id: params[:id], theme_id: params[:theme_id]).destroy
    flash[:alert] = '投稿を削除しました'
    # 非同期化のため@theme,@answersの値渡す
    @theme = Theme.find(params[:theme_id])
    @answers = Answer.where(theme_id: @theme.id, status: true).sort{|a,b| b.likes.count <=> a.likes.count}
    render :theme_answers
  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
