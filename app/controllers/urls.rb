enable :sessions

get '/' do
  # Deja a los usuarios crear una URL reducida y despliega una lista de URLs.
  @urls = Url.all.reverse
  erb :index
end

post '/urls' do
  # crea una nueva Url
  newURL = Url.new(long_url: params[:new_url] , click_count: 0)
  if newURL.valid?
    newURL.save
    # session[:errors].clear if session[:errors]
    p session[:message] = "saved"
    else
    p "X"*50
    p session[:message] = newURL.errors.full_messages * " , "
  end
  redirect to '/secret/:user'
end

# redirige a la URL originals
get '/short_url/:url_id' do
  p "*" * 50
  # asignar el Url que tenga el id en :url_id
  url = Url.find(params[:url_id])
  url.add_click
  redirect to "#{url.long_url}"
end
