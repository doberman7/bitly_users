# bitly_users
DIAGRAMA: https://drive.google.com/file/d/0B9z566E1IBDBa2IxeWhNVE1lY1E/view?usp=sharing

Bitly Con Usuarios

Vamos a incorporar usuarios a nuestra app de Bitly. Esto hará que los usuarios puedan guardar una lista de las urls que han creado y la posibilidad de crear urls privadas.

Hasta ahora esta será la aplicación más complejas que habrás creado, impleméntala poco a poco y divide tu problema en pedazos pequeños que sean fáciles de implementar. Crea un plan de que funcionalidades debes crear primero. Busca a un instructor si te cuesta trabajo decidir que deberás hacer primero.

Objetivos Académicos
Seguir aprendiendo sobre asociaciones en Activerecord
Aprender a juntar dos pedazos de código o apps en una sola.
Seguir explorando como funciona la autorización
Actividades
Pega las dos apps
Empieza por juntar las dos aplicaciones, recuerda que no solo es un copy/paste, hay también que crear las migraciones, modelo y controladores relevantes y ver que todo este funcionando correctamente.

Nota: antes de seguir con el siguiente paso, la lógica para crear urls y la lógica de autenticación deberán funcionar correctamente.

La app de Bitly deberá funcionar de la misma forma, solo que ahora un usuario tendrá la opción de registrarse y acceder a su cuenta. En el caso de que Inicien Sesión si crean una url esta deberá quedar asociada a su cuenta. En otras palabras una Url pertenece a una cuenta, y una cuenta puede tener varias urls. Ya sea que un usuario tenga una sesión o no. Revisa la documentación acerca de asociaciones en Active Record.

Te recomendamos empezar a dividir tus controladores:

app/controllers/urls.rb, este file deberá contener las acciones que crean, enlistan y redirigen a la long_url.
app/controllers/sessions.rb, contiene las rutas para Iniciar sesión y terminarla
app/controllers/users.rb, contiene las rutas para crear, enlistar, editar, etc para usuarios.
Iniciar sesión, cerrar sesión y el usuario actual (current_user)
Las personas deberán poder crear urls sin importar si tienen sesión o no. Esto es que el user_id en la tabla de urls podrá estar vació.

En el caso en el que el usuario tiene una sesión activa, si crea una url entonces deberás poner el id del usuario con la sesión actual (current_user) en la columna de user_id. Esta información no debe de venir de la forma de HTML, ya que cualquiera puede cambiar ese valor.

Para esto deberás crear un método helper en la siguiente carpeta app/helpers/user.rb.

Sigue el siguiente código para crear este método.

helpers do
  # Esto deberá de regresar al usuario con una sesión actual si es que existe
  def current_user
  end

  # Regresa true si el current_user existe y false de otra manera
  def logged_in?
  end
end
Ahora podrás correr desde tu controlador estos métodos y no dependerás de que el usuario te envíe dicha información.

Perfil del Usuario
Por último crea una página de perfil para el usuario donde enlistes todas las urls que ha creado, además de sus datos personales (nombre y email). También junto a las urls deberás mostrar el contador de clicks para que el usuario se emocione de la cantidad de personas que han hecho click en sus urls

get '/users/:id' do
end
