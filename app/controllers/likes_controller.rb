class LikesController < ApplicationController
  def index
    # @new_likes = current_user.likes.includes(:user).order(created_at: :desc).page(params[:new_page]).per(3)
    @new_likes = current_user.likes.includes(:user, :answer).order(created_at: :desc).page(params[:new_page]).per(3)
    @popular_likes = Like.includes(:user, :answer).where(user_id: current_user.id).sort { |a, b| b.answer.likes.size <=> a.answer.likes.size }
    @popular_likes = Kaminari.paginate_array(@popular_likes).page(params[:popular_page]).per(3)
  end

  def create
    @answer = Answer.find(params[:answer_id])
    @likes = current_user.likes.new(answer_id: @answer.id)
    @likes.save
  end
end
