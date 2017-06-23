#A session is a way for a web application to set a cookie that persists an identifier across multiple HTTP requests, and then relate these requests to each other
enable :sessions
#-----------------------------------------------------
#Evitar que un error de validacion se vea directamente..
# require 'sinatra'
# set :show_exceptions, false
# #The exception object can be obtained from the sinatra.error Rack variable:
# error do#.. en lugar de eso se lanza esta opcion
#   @fuck = "something's FUCK'T UP...some where"
#   # erb :sign_up
# end
#---------------------------------------
before '/secret/:user_id' do
  #p "BEFORE SECRETE USER" + "<" * 100
  # Evaluar si el user esta logeadoi
	#p "logged_in" + "-" *50
  #p logged_in?
  case logged_in?
  # in the case that user is true
  when true
    #p "@user_details NO ES NIL" + "<"*100
    # asign var name to see in the view
    session[:error].clear if session[:error] != nil
     user = User.find(session[:user_id])
     p "x"*50
     @id = user.id
     #p "x"*50
     @name = user.name
     # asign var id to see in the view
     #p @id = user.id
		 # asign var mail to see in the view
     @mail = user.email
     #p "x"*50
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

#------------------
#SING UP
post '/sign' do
  # Asignar a @user entradas del formulario en los PARAMS name, email y password
  user = User.new(name: params[:user_name],email: params[:user_email],password: params[:user_password])
  case user.valid?
    when true
      @user = user
      @user.save!
      #se ve en consola y en layout:
      #p "*" * 100
      p session[:saved_message] = "Successfully stored"#en layout se establecio que se visualize el @user.name si este no es nil
      #renderear pagina de log in
      # session[:rong_log_in].clear if session[:rong_log_in].clear != nil

      #p "*"*100
      erb :log_in
    when false
      session[:error] = user.errors.full_messages.each do |e|
         p e
      end
      redirect to '/sign'
    # Para el sinatra error Stack
    # else
    #   error
    #   p user
  end

end#fin de post '/signUP'

#ruta para el pagina secreta
get '/secret/:user_id' do
  # reder pagina secreta
  erb :secret_page#=>GET
end
#LOG_page------------------------
# peticion si el login es exitoso
post '/log_page' do
  #Autenticar objeto con metodo ".authenticate" creado en MODELO con lo inputs del formulario
  p "AUTETICACION y creacion de SESSION" + "-" * 50
  p "-"*50
  p user = User.authenticate(params[:email], params[:password])
  #p user.id
  #metodo en helpers/user.rb
  #p "+"*50
  
  p session[:user_id] = user.id if user != nil
  logged_in?
  redirect to '/secret/:user_id'
end#FIN de post '/log_page'
