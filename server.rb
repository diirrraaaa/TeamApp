require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra'
require './model'

set :port, 3000
set :database, {adapter: "postgresql", database: "social_database", username: 'postgres', password: ENV['POSTGRES_PW'], port: '9000'}
enable :sessions

get '/' do
  erb :home
end

get '/login' do
  erb :login
end

post'/login' do
  @user = User.find_by(email: params[:email])
  @given_password = params[:password]
  if @user.password == @given_password
    session[:user_id] = @user.id
    session[:user_name] = @user.name
    redirect '/profile'
  else
    flash[:error] = "Correct email, but wrong password. Did you mean: #{user.password}?\
    Only use this password if that is your account."
    redirect'/signup'
 end
end


get '/signup' do
  erb :signup
end

post '/signup' do
  p params
  @user = User.new(params[:user])
 if @user.valid?
   @user.save
   session[:user_id] = @user.id
   redirect:'/profile'
 else
  flash[:error] = @user.errors.full_messages;
  redirect:'/signup'
 end
end

get'/profile' do
  @posts = Post.all
  erb :profile
end
post '/profile' do
  if session[:user_id]
erb :profile
 end
end

post '/profile/:name' do
    @user = User.find_by(email: session[:user_email])
    redirect %(/profile#{session[:name]})
erb :profile
end

get '/posts' do
  @posts = Post.all
  erb :posts
end

post '/posts' do
@post = Post.new(title: params[:title], content: params[:content], user_id: session[:user_id])
  if @post.valid?
      pp @post
      @post.save
      redirect '/posts'
  else
      flash[:errors] = @post.errors.full_messages
      redirect '/posts'
  end
end

get'/logout' do
  session[:user_id] = nil
  redirect'/'
end
