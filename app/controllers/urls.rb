enable :sessions

before '/secret/:user_id' do
  @urls = Url.all.reverse
end

get '/' do
  # Deja a los usuarios crear una URL reducida y despliega una lista de URLs.
  session[:rong_log_in].clear if session[:rong_log_in].class == String
  @urls = Url.all.reverse
  erb :index
end

# redirige a la URL originals AQUI
get '/short_url/:url_id' do
  # asignar el Url que tenga el id en :url_id
  #p "*" * 50
   url = Url.find(params[:url_id])
   url.add_click
  #p "*" * 50
  redirect to "#{url.long_url}"
end

post '/urls' do
  p "w"*60
  # crea una nueva Url
  newURL = Url.new(long_url: params[:new_url] , click_count: 0)
  if newURL.valid?
    #p " @"*50
    newURL.save
    #metodo de helpers/user.rb, poner el id del usuario con la sesión actual (current_user) en la columna de user_id.s
    session[:newURL_id] = Url.last.id
    current_user
    #p " @"*50
    # session[:errors].clear if session[:errors]
    session[:message] = "Url salvado"
    if logged_in? == true
      redirect to "secret/:user_id"
      else
     redirect to "/"
    end
  else
    #p "X"*50
    p session[:message] = newURL.errors.full_messages * " , "
    if logged_in? == true
      redirect to "secret/:user_id"
      else
     redirect to "/"
    end
  end

end
