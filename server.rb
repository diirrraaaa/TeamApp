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



get '/profile' do
erb :profile
 end
get '/NewPost' do
  erb :submit
end

get '/posts' do
  @posts = Post.all
  erb :posts
end

get '/posts/new' do
  # erb should have a form passing in the title and content only!! to the /posts route with a POST method
  erb :new_post 
end

post '/posts' do

  # check if session user_id is valid, otherwise redirect to login

  # if they are logged in,
  # create a new post with the params as its values but also get the user_id value from session["user_id"]
  # save and redirect to the posts page
end


# get '/NewPost' do
#   @Submission = Submission.new(params[:Submission])
#    if @Submission.save
#    session[:new_post] = Submission.image
#     redirect:'/profile'
#   else
#     flash[:error] = "Sorry! Your post failed to upload!"
#     redirect:'/submit'

#  end
#   p params
# end


get'/logout' do
  session[:user_id] = nil
  redirect'/'
end
