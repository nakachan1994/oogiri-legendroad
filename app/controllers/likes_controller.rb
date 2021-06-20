class LikesController < ApplicationController

  def index
    @new_likes = current_user.likes.order(created_at: :desc).page(params[:new_page]).per(3)
    @popular_likes = Like.where(user_id: current_user.id).sort{|a,b| b.answer.likes.count <=> a.answer.likes.count}
    @popular_likes = Kaminari.paginate_array(@popular_likes).page(params[:popular_page]).per(3)
  end

  def create
    @answer = Answer.find(params[:answer_id])
    @likes = current_user.likes.new(answer_id: @answer.id)
    @likes.save
  end
end
