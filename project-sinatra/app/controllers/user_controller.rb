class UserController < ApplicationController

    post "/signup" do
        u = User.new(params)
        if u.email.blank? || u.password.blank? || User.find_by_email(params["email"])
            redirect '/signup'
        else
            u.save
            session[:user_id] = u.id
            redirect '/courses'
        end
    end

    get '/signup' do
        erb :"users/new"
    end

    get '/logout' do
        session.clear
        redirect '/login'
    end

    get '/login' do
        erb :"/users/login"
    end

    post '/login' do
        user = User.find_by_email(params[:email])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect '/courses'
        else
            redirect '/signup'
        end
    end
end