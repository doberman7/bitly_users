helpers do
	# Regresa true si el current_user existe y false de otra manera
  def logged_in?
		# p " #"*50
		# p session[:user_datails].id
		if session[:user_datails]
			if session[:user_datails].id != nil
				true
			else
				false
			end
		end
  end
	#En el caso en el que el usuario tiene una sesión activa, si crea una url entonces deberás poner el id del usuario con la sesión actual (current_user) en la columna de user_id.s
  # Esto deberá de regresar al usuario con una sesión actual si es que existe
  def current_user
		#p " #"*50
		if logged_in? == true
			if session[:newURL] != nil
				session[:newURL].update!(user_id: session[:user_datails].id)
			end
		end
  end
end
