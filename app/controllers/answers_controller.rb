class AnswersController < ApplicationController
  def index
    @answers = Answer.all
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

  end

  private

  def answer_params
    params.require(:answer).permit(:content)
  end
end
