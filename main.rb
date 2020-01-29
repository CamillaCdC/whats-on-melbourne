require 'sinatra/reloader'
require 'sinatra'
require 'bcrypt'
require 'pry'

also_reload 'db/shared.rb'
also_reload 'controllers/organiser_controller.rb'
also_reload 'controllers/event_controller.rb'
also_reload 'controllers/user_controller.rb'
also_reload 'controllers/question_controller.rb'
also_reload 'models/event.rb'
also_reload 'models/organiser.rb'
also_reload 'models/user.rb'
also_reload 'models/question.rb'

require_relative 'db/shared.rb'

require_relative 'controllers/organiser_controller.rb'
require_relative 'controllers/event_controller.rb'
require_relative 'controllers/user_controller.rb'
require_relative 'controllers/question_controller.rb'

require_relative 'models/event.rb'
require_relative 'models/organiser.rb'
require_relative 'models/user.rb'
require_relative 'models/question.rb'

enable :sessions

get '/' do
    @events = all_events()
    erb :index
end

delete '/session' do 
    session[:organiser_id] = nil
    session[:user_id] = nil
    redirect '/'
end