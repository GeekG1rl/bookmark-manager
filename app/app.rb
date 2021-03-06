require 'sinatra/base'
require_relative 'models/link'

class BookmarkManager < Sinatra::Base
  get '/' do
    redirect '/links'
  end

  get '/links' do
    @links = Link.all 
    erb :index
  end

  get '/links/new' do
    erb :new_link
  end

  post '/links' do
    Link.create(title: params[:title], url: params[:url])
    redirect '/'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end