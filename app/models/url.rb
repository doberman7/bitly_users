require 'uri'
require "net/http"

class Url < ActiveRecord::Base


	#VALIDA ATRIBUTOS: validates(*attributes)
	validates :long_url, presence: true
	validates :click_count, presence: true

	# This helper validates the attributes' values by testing whether they match a given regular expression, which is specified using the :with option.
	#NO ESTA SOPORTANDO ANALISIS DESDE EL INICIO CON /A PREGUINTAR A ABEL
	validates :long_url, format: { with: /(http|https):\/\/[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?/, message: "formato de URL incorrecto" }

	# before_create :check_uri

	#Active Record Callback: antes de crear registro en la BD se usa methodo:
	before_create :create_short_url

	#Adds a validation method or block to the class. This is useful when overriding the validate instance method becomes too unwieldy and you're looking for more descriptive declaration of your validations.
	#This can be done with a symbol pointing to a method:
	validate :check_uri

	def create_short_url
		#prefijo del shot url
		shrt_url = ""
		3.times do
			#traerse el ascci entre numeros aleatorio
			#https://en.wikibooks.org/wiki/Ruby_Programming/ASCII
			str = []
			2.times do
				str<<(rand(65..90)).chr#letra aleatoria entre A - Z
				str<<(rand(97..122)).chr#letra aleatoria entre a - z
				shrt_url << str.sample
			end
		end
		#asignar el ary a atributo short_url del Url
		self.short_url = shrt_url
	end
	def add_click
		#sumar 1 al atributo click_count
		self.click_count = click_count + 1
		# ActiveRecord metod update: actualizar el atributo click_count
		self.update(click_count: click_count)
	end
	#AQUI
	def check_uri
		p "<"*50
		#Creates one of the URI’s subclasses instance from the string.
		uri = URI::parse(self.long_url)
		p "HOST: #{uri.host}"
		p "PORT: #{uri.port}"
		p "PATH: #{uri.path}"
		p "SCHEME: #{uri.scheme}"
		p "QUERY: #{uri.query}"
		p "FRAGMENT: #{uri.fragment}"
		# puts URI.split(self.long_url)
		# p URI.scheme_list
		if uri.scheme == "http" || uri.scheme == "https"
			#Sends a GET request to the target and returns the HTTP response as a Net::HTTPResponse object. The target can either be specified as (uri), or as (host, path, port = 80); so:
			p "0"*50
			res = Net::HTTP.get(uri)
			
			p "OBJETO NET con get response: #{res}"
			p "MESAGE: #{res.message}"
			# p "CLASS NAME #{res.class.name}"
			p "OBJETO NET code: #{res.code}"
			p "OBJETO NET body: #{res.body}"
			errors.add(:base, 'error 404 NOT FOUND') if res == "Not Found"
			p "0"*50
		end
		p "<"*50

	end
end
