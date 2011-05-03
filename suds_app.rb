require 'sinatra'
require 'datamapper'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/pdxxx_society.db")


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

get '/' do
        @bars = Bar.all :order => :BarId.desc
        @title = 'Home'
        erb :home
end

