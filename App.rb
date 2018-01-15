class App < Sinatra::Base

  enable :sessions
  register Sinatra::Flash

  def initialize
    super

  end

  get '/' do
    slim :index
  end

  post '/login' do
    if session[:uid] == nil
      if Users.all(:name => params['name']).any?
        if Users.all(:name => params['name'])[0].password == params['pass']
          session[:name] = params['name']
          session[:uid] = Users.all(:name => params['name'])[0].id
          redirect 'start'
        else
          # session[:fail_msg] = 'Wrong password!'
          flash[:blah] = "Password wrong"
          redirect '/failure'
        end
      else
        Users.create(:name => params['name'], :password => params['pass'])
        session[:name] = params['name']
        session[:uid] = Users.all(:name => params['name'])[0].id

        redirect 'register_bmr'
      end
    else
      redirect '/start'
    end

  end

  get '/start' do
    if session[:uid] != nil
      @name = session[:name]
      user =  Users.all(:id => session[:uid])[0]
      @consumed = user.consumed.to_f
      @of_total = ((@consumed/user.bmr.to_f)*100).round
      @items = Dishes.all()
      slim :start
    else
      redirect '/'
    end
  end

  post '/add_cal' do
    p "works!!"
    cals = (Dishes.all(:id => params['id_food'])[0].kcal.to_i)*params['amount_food'].to_i
    user = Users.all(:id => session[:uid])[0]
    user.update(:consumed => (user.consumed+cals))
    redirect 'start'
  end

  get '/failure' do
    # @fail_msg = session[:fail_msg]
    p @fail_msg = flash[:blah]
    slim :failure
  end

  post '/logout' do
    session.destroy
    redirect '/'
  end

  get '/db' do
    @db_data = Trips.all()
    slim :db
  end

  get '/register_bmr' do
    slim :bmr
  end

  post '/bmr' do
    activity_rates = [1.2, 1.375, 1.55, 1.725, 1.9]

    if params["gender"] == "female"
      bmr = ((10*params["weight"].to_i) + (6.25*params["length"].to_i) - (5*params["age"].to_i) - 161)*(activity_rates[(params["activity"].to_i)-1])
    elsif params["gender"] = "male"
      bmr = ((10*params["weight"].to_i) + (6.25*params["length"].to_i) - (5*params["age"].to_i) + 5)*(activity_rates[(params["activity"].to_i)-1])
    end

    user = Users.all(:id => session[:uid])[0]
    user.update(:bmr => bmr, :consumed => 0)

    redirect 'start'

  end

end

