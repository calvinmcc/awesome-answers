Rails.application.routes.draw do
  get 'likes/create'

  get 'likes/destroy'

  # when we receive a get request with the '/' url we invoke the index application
  # # within the home controller
  # get '/' => "home#index", as: :home # home_path
  #   # controller#action

  root 'home#index'

  get '/contact' => "home#contact" #Rails auto-generates a URL helper called contact_path
                                  # and contact_url

  post '/contact_submit' => 'home#contact_submit'


  get '/contact_submit' => 'home#contact_submit'

  resources :questions, shallow: :true do
    resources :likes, only: [:create, :destroy]
    resources :votes, only: [:create, :destroy, :update]
    # when we define a route within the block for 'resources' we make the route
    # asscociated with the questions controller. We have different options we
    # can use with these routes:
    # on: :collection => this makes the route not include an :id or :question_id
    # in it. This is very similar to the 'index' action url
    # this is equivalent to:
    # get '/questions/search' => 'questions#search', as: :search_questions
    get :search, on: :collection
    # on: :member => this makes the route include an ':id' this is usually
    # useful for routes on actions that are related to a given recoredd
    # this is somewhat similar to the 'edit' action
    # get '/questions/:id/flag' => 'questions#flag' as: :flag_question
    get :flag, on: :member


    # if you don't include any option (neither collection nor member) then
    # you're defining a nested resource, which means it will include
    # ':question_id' in the URL
    # would be POST '/questions/:question_id/approve' => 'questions#approve',
    # as: :question_approve
    post :approve


    # nesting the answers resources within the questions resources block
    # will make it so that every 'answers' route is prefixed with :
    # '/questions/:question_id'. We will need the 'question_id' to create
    # or answer associated with a question so we will stick with this way of
    # defining the routes. The route helpers will also have 'question_' prefix
    resources :answers, only: [:create, :destroy]
  end

    resources :users, only: [:new, :create]

    resources :sessions, only: [:new, :create, :destroy] do
      delete :destroy, on: :collection
    end



  # get '/questions/new' => 'questions#new', as: :new_question
  #
  # post '/questions' => 'questions#create', as: :questions
  #
  # get '/questions/:id' => 'questions#show', as: :question
  #
  # # the url helpers (when we set it using 'as') is only concerned about the URL
  # # and not the VERB. So even if we have two routes with the same url and
  # # different verbs, the url helper should be the same
  #
  # get '/questions' => 'questions#index'
  #
  # get '/questions/:id/edit' => 'questions#edit', as: :edit_question
  #
  # patch '/questions/:id' => 'questions#update'
  #
  # delete '/questions/:id' => 'questions#destroy'

end
