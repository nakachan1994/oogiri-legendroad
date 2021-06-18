class LikesController < ApplicationController

  def index
    @likes = current_user.likes.order(created_at: :desc).page(params[:page]).per(3)
  end

  def create
    @answer = Answer.find(params[:answer_id])
    @likes = current_user.likes.new(answer_id: @answer.id)
    @likes.save
  end
end
