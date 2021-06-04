class LikesController < ApplicationController
  def index
    @likes = current_user.likes
  end

  def create
    @answer = Answer.find(params[:answer_id])
    @likes = current_user.likes.new(answer_id: @answer.id)
    @likes.save
    redirect_to theme_path(@answer.theme)
  end
end
