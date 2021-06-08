class LikesController < ApplicationController

  def index
    @likes = current_user.likes.order(created_at: :desc)

  end

  def create
    @answer = Answer.find(params[:answer_id])
    @likes = current_user.likes.new(answer_id: @answer.id)
    @likes.save
    redirect_back(fallback_location: root_path)
  end
end
