class AnswersController < ApplicationController
  before_action :authenticate_user

  def create
    # render json: params
    @question = Question.find params[:question_id]
    answer_params = params.require(:answer).permit(:body)
    @answer = Answer.new answer_params
    @answer.question = @question
    @answer.user = current_user
    if @answer.save
      redirect_to question_path(@question), notice: 'Answer created!'
    else
      render 'questions/show'
    end
  end

  def destroy
    question = Question.find params[:question_id]
    answer = Answer.find params[:id]
    if can? :delete, answer
      answer.destroy
      redirect_to question_path(question), notice: 'Answer deleted'
    else
      redirect_to root_path, notice: "Access denied"
    end
  end

end
