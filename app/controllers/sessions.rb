
#Crear cuenta de usuario
#---------------------------------
# SING IN

get '/sign' do
  erb :sign_up
end


after "/log_page" do
  session[:message] = "Bienvenido"
end

after '/secret/:user_id' do
  #p 'after /secret/:user' + "."*100
  # creaser session con la fecha actual
  session[:time] = Time.now
end

get '/secret/:user_id'do
  # purgar session login equivocado
  session[:rong_log_in].clear if session[:rong_log_in] != nil
  session[:rong_log_in].clear if session[:rong_log_in].class == String
  # reder pagina secreta
  erb :secret_page#=>GET
end

# Logearse como usuario existente
#---------------------------------
# LOG

get '/log' do
  erb :log_in
end

#peticion GET a pagina de inicio
get '/logout' do
	session[:message].clear if session[:message] != nil
  #p "<"*60
  session[:user_id] = nil
  session[:user_id].clear if session[:user_id] != nil
	redirect to '/'
end
