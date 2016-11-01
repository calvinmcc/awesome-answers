class LikesController < ApplicationController
  before_action :authenticate_user
  def create
    question = Question.find(params[:question_id])
    like = Like.new(user: current_user, question: question)
    if cannot? :like, question
      redirect_to :back, notice: "👿don't like ur own post weirdo👿"
    elsif like.save
      redirect_to :back, notice: "👻thanks for liking👻"
    else
      redirect_to :back, alert: "💀you liked it already dummy💀"
    end
  end

  def destroy
    like = Like.find params[:id]
    if like.destroy
      redirect_to :back, notice: "🤖unliked🤖"
    else
      redirect_to :back, alert: like.errors.full_messages.join(', ')
    end
  end
end
