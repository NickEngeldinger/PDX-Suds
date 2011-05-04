require 'sinatra'
require 'datamapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/suds.db")


class Bar
        include DataMapper::Resource
        property :BarId, Serial
        property :BarName, Text
        property :BarAddy, Text
        property :BarDesc, Text
        property :BarImage, Text
        property :BarHours, Text
end

class Users
	include DataMapper::Resource
	property :UserId, Serial
	property :UserName, Text
	property :Password, Text
	property :Email, Text
	property :Admin, Boolean
end

class Reviews
	include DataMapper::Resource
	property :ReviewId, Serial
	property :ReviewTitle, Text
	property :ReviewText, Text
	property :Rating, Integer
	property :ReviewDate, DateTime
end

class Sponsored
	include DataMapper::Resource
	property :SponsId, Serial
	property :SponsTitle, Text
	property :SponsText, Text
end

class Special
	include DataMapper::Resource
	property :SpecId, Serial
	property :SpecTitle, Text
	property :SpecText, Text
	property :SpecExDate, DateTime
end

DataMapper.finalize.auto_upgrade!

helpers do  
        include Rack::Utils  
        alias_method :h, :escape_html  
end  

get '/' do
        @reviews = Reviews.all :order => :ReviewId.desc
        @sponsors = Sponsored.all :order => :SponsId.desc
	@title = 'Home'
        erb :home
end

get '/add' do
	@title = "Add a Review"
	erb :add
end

post '/add' do
	r = Reviews.new
	r.ReviewTitle = params[:ReviewTitle]
	r.ReviewText = params[:ReviewText]
	r.Rating = params[:Rating]
	r.ReviewDate = Time.now
	r.save
	redirect '/'

	s = Sponsored.new
	s.SponsTitle = params[:SponsTitle]
	s.SponsText = params[:SponsText]
	s.save
	redirect '/'
end	

get '/listing' do
	@reviews = Reviews.all :order => :ReviewId.desc
	@title = "Listings"
	erb :listing
end

not_found do
	@title = "Page Not Found"
	erb :page404
end
