class QuestionsController < ApplicationController
  # this action is to show the form for creating a new questions
  # URL: /questions/new
  # path helper is: new_question_path
  # before_action method here registers a method (usually private) to
  # be executed just before controller actions. This happens within the
  # same request/response cycle which means if you define an instance
  # variable it will be available within action
  # you can optionally give options: 'only' or 'except' to restrict the actions
  # that this 'before_action' method applies to
  before_action :authenticate_user, except: [:index, :show]
  before_action :find_question, only: [:edit, :update, :destroy, :show]
  before_action :authorize_access, only: [:edit, :update, :destroy]
  # better to use only because you are more explicit, if you add methods later
  # they will be included in the before_action

  #before_action's will be called in the order in which they are defined

  def new
    @question = Question.new
  end


  # this action is to handle creating a new question after submitting the form
  # that was shown in the new action
  def create
    # Question.create question_params

    # checks if question passes validations or not:
    @question = Question.new question_params
    @question.user = current_user
    if @question.save
    # render --- basically just print or doc.write
      # redirect_to question_path({id: @question.id}) OR
      flash[:notice] = "Question created!"
      redirect_to question_path(@question)
    else
      #re-renders the new question page
      flash.now[:alert] = 'Please see errors below:'
      render :new
    end
  end

  # this action shows info about specific question
  # URL: /questions/:id
  # method: GET
  def show
    # find_question
    # render plain: "In show action"
    @answer = Answer.new
  end

  # this action shows a listing of all the questions
  # URL: /questions
  # method: GET
  def index
    @questions = Question.order(created_at: :desc)
  end

  # this action is to show a form pre-populated with the question's data
  # URL /questions/:id/edit
  # method: GET
  def edit
    # find_question
  end

  # this action is to capture the params from the form submission from the
  # edit action in order to update a question
  # URL: /questions/:id
  # method: PATCH
  def update
    # find_question
    # question_params = params.require(:question).permit([:title, :body])
    if  @question.update question_params
    flash[:notice] = "Question updated!"
    # also can add 'notice: 'Question updated' to redirect line- same thing
    # only works for redirect though, not render
    redirect_to question_path(@question)
    else
      flash.now[:alert] = 'Please see errors below:'
      render :edit
    end

    # render plain: 'in update action'
  end

  # this action handles deleting a question
  # URL: /questions/:id
  # method: DELETE
  def destroy
    # find_question
    @question.destroy
    flash[:notice] = "Question deleted!"
    redirect_to questions_path
    # render plain: 'hey'
  end

  private #because it's not an action

  def authorize_access
    unless can? :manage, @question
      # head :unauthorized -- this will send an empty HTTP response with 401 code
      redirect_to root_path, notice: "Access denied"
    end
  end

  def question_params
    question_params = params.require(:question).permit([:title, :body])
  end

  def find_question
    @question = Question.find params[:id]
  end

end
