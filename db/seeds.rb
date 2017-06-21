 require 'faker'

10.times do |n|
  puts User.create!(name: Faker::Name.name ,email: Faker::Internet.email,password: 123456)
end

#p require_relative '../app/models/url.rb'#no fuciona para traerse el method create_short_url

def create_short_url
		short_url = ""
		3.times do
			#traerse el ascci entre numeros aleatorio
			#https://en.wikibooks.org/wiki/Ruby_Programming/ASCII
			str = []
			2.times do
				str<<(rand(65..90)).chr#mayuscula
				str<<(rand(97..122)).chr#minuscula
				short_url << str.sample
			end
		end
		short_url
end

#para que seed funcione necesario descomentar, ya que el require_relative no fuciona

5.times do
	Url.create!(long_url: "https\://github.com/stympy/faker", short_url: create_short_url, click_count: 0, user_id: 1)
end
5.times do
	Url.create!(long_url: "https\://github.com/stympy/faker", short_url: create_short_url, click_count: 0, user_id: 2)
end
5.times do
	Url.create!(long_url: "https\://github.com/stympy/faker", short_url: create_short_url, click_count: 0, user_id: 0)
end
