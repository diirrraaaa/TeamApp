require 'sinatra/activerecord'
require 'sinatra/flash'
require 'sinatra'
require './model'
# require './post_model'

set :port, 3000
set :database, {adapter: "postgresql", database: "social_database", username: 'postgres', password: ENV['POSTGRES_PW']}
enable :sessions

get '/' do
  erb :home
end

get '/login' do
  erb :login
end

get'/login' do
  @user = User.find_by(email: params[:email])
  given_password = params[:password]
  if user.password. == given_password
    session[:user_id] = user.id
    session[:user_name] = user.name
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
  @user = User.new(params[:user])
 if @user.valid?
   @user.save
   redirect:'/profile'
 else
  flash[:error] = @user.errors.full_messages;
  redirect:'/signup'
 end
 p params
end



get '/profile' do

erb :profile
 end
get '/NewPost' do
  erb :submit
end

get '/NewPost' do
  @Submission = Submission.new(params[:Submission])
   if @Submission.save
   session[:new_post] = Submission.image
    redirect:'/profile'
  else
    flash[:error] = "Sorry! Your post failed to upload!"
    redirect:'/submit'

 end
  p params
end


get'/logout' do
  session[:user_id] = nil
  redirect'/'
end
