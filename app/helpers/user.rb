helpers do
	# Regresa true si el current_user existe y false de otra manera
  def logged_in?
		 p " #"*50
		# p session[:user_id].id
    p session[:user_id]
		if session[:user_id]
			if session[:user_id] != nil
			p	true
			else
			p	false
			end
		end
  end
	#En el caso en el que el usuario tiene una sesión activa, si crea una url entonces deberás poner el id del usuario con la sesión actual (current_user) en la columna de user_id.s
  # Esto deberá de regresar al usuario con una sesión actual si es que existe
  def current_user
		if logged_in? == true

        #p "="*50
				p Url.where(id: session[:newURL_id]).update(user_id: session[:user_id])
        #p "="*50

		end
  end
end
