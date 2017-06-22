enable :sessions

before '/secret/:user' do
  @urls = Url.all.reverse
end

get '/' do
  # Deja a los usuarios crear una URL reducida y despliega una lista de URLs.
  @urls = Url.all.reverse
  erb :index
end

# redirige a la URL originals
get '/short_url/:url_id' do
  p "*" * 50
  # asignar el Url que tenga el id en :url_id
  url = Url.find(params[:url_id])
  url.add_click
  redirect to "#{url.long_url}"
end

post '/urls' do
  # crea una nueva Url--------------------------
  newURL = Url.new(long_url: params[:new_url] , click_count: 0)
  if newURL.valid?
    #metodo de helpers/user.rb, poner el id del usuario con la sesión actual (current_user) en la columna de user_id.s
    session[:newURL_id] = newURL.user_id
    current_user
    newURL.save
    # session[:errors].clear if session[:errors]
    p session[:message] = "Url salvado"
  else
    #p "X"*50
    p session[:message] = newURL.errors.full_messages * " , "
  end
  redirect to '/secret/:user'
end
