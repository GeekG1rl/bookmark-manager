
ENV["RACK_ENV"] ||= "development"

require 'sinatra/base'
require_relative 'data_mapper_setup'

class BookmarkManager < Sinatra::Base
  get '/' do
    redirect to '/links'
  end

  get '/links' do
    @links = Link.all
    erb :index
  end

  get '/links/new' do
    erb :new_link
  end

  post '/links' do
    link = Link.create(title: params[:title], url: params[:url])
    params[:tags].split.each do |tag|
      link.tags << Tag.create(name: tag)
    end
    link.save
    redirect to '/links'
  end

  get '/tags/:name' do
    tag =Tag.all(name: params[:name])
    @links = tag ? tag.links : []
    erb :index
  end

  run! if app_file == $PROGRAM_NAME
end
