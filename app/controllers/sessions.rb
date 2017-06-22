after "/log_page" do
  session[:message] = "Bienvenido"
end

after '/secret/:user' do
  #p 'after /secret/:user' + "."*100
  # creaser session con la fecha actual
  session[:time] = Time.now
end

before '/secret/:user' do
  #p "BEFORE SECRETE USER" + "<" * 100
  # Asignar boleano si en caso de que la session se clase user
  user = session[:user_datails].class == User

  case user
  # in the case that user is true
  when true
    #p "session[:user_datails] NO ES NIL" + "<"*100
    # asign var name to see in the view
     @name = session[:user_datails].name
     # asign var id to see in the view
     @id = session[:user_datails].id
		 # asign var mail to see in the view
     @mail = session[:user_datails].email

    #  despejar la sessiin que mensajea un login errorneo
     session[:rong_log_in].clear if session[:rong_log_in] != nil
  # if user false
  when false
    #SESIONSS display the message of rong login
    p session[:rong_log_in] = "Email o password incorrectos, favor de logearse con credenciales validas "
    #renderear log_in nuevamente
    redirect to'/log'
  end

end

get '/secret/:user'do
  # purgar session login equivocado
  session[:rong_log_in].clear if session[:rong_log_in] != nil
  session[:rong_log_in].clear if session[:rong_log_in].class == String
  # reder pagina secreta
  erb :secret_page#=>GET
end
