class HomeController < ApplicationController
  # this method is called 'action' (like the get '/' do and erb :index in sinatra)
  def index
    # this will render views/home/index.html.erb and it will use
    # views/layouts/application.html.erb
    # render :index, layout: 'application'
    # the line above is a convention and will run by default, unnecessary

  end

  def contact
  end

  def contact_submit
    @name = params[:full_name]
  end

end
