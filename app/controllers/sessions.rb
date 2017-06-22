
before '/' do
  if @user_details != ""
    # p "BEFORE /" + "=" * 100
    # p @user_details= "SESION TERMINADA"
    # #@user_details.clear
    session[:goodbye] = "vuelve pronto"
  else
    p session[:goodbye].clear
  end
end

#Crear cuenta de usuario
#---------------------------------
# SING IN
before '/sign' do
  session[:goodbye].clear
end
get '/sign' do
  session[:goodbye].clear
  erb :sign_up
end


after "/log_page" do
  session[:message] = "Bienvenido"
end

after '/secret/:user' do
  #p 'after /secret/:user' + "."*100
  # creaser session con la fecha actual
  session[:time] = Time.now
end

get '/secret/:user'do
  # purgar session login equivocado
  session[:rong_log_in].clear if session[:rong_log_in] != nil
  session[:rong_log_in].clear if session[:rong_log_in].class == String
  # reder pagina secreta
  erb :secret_page#=>GET
end

# before '/logout' do
# 	@user_details = ""
# 	@user_details.clear
# end

# Logearse como usuario existente
#---------------------------------
# LOG
before '/log' do
  session[:goodbye].clear
end

get '/log' do
  session[:goodbye].clear
  erb :log_in
end

#peticion GET a pagina de inicio
get '/' do
  session[:rong_log_in].clear if session[:rong_log_in].class == String
  erb :index
end

get '/logout' do
	session[:message].clear
	#session[:goodbye].clear
	@user_details = ""
	@user_details.clear
	redirect to '/'
end
