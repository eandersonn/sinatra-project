class CourseController < ApplicationController

    get '/courses' do
        #displayes all the courses 
        @courses = Course.all
        erb :"courses/index"
    end

    post '/courses' do
        #adding new courses
        redirect_if_not_logged_in
        course = Course.new(params)
        course.user_id = session[:user_id]
        course.save
        redirect '/courses'
    end

    get '/courses/new' do
        #creates a new course form
        if !logged_in?
            redirect '/login'
        end
        erb :"courses/new"
    end

    get '/courses/:id' do
        #displays a specific courses
        redirect_if_not_logged_in
        @course = Course.find(params["id"])
        erb :"courses/show"
    end

    put '/courses/:id' do
        #update course
        @course = Course.find(params["id"])
        redirect_if_not_authorized
        @course.update(params["course"])
        redirect "/courses/#{@course.id}"
    end

    delete '/courses/:id' do
        #delete courses
        @course = Course.find(params["id"])
        redirect_if_not_authorized
        @course.destroy
        redirect '/courses'
    end

    get '/courses/:id/edit' do
        #edit the course form for a specific course
        @course = Course.find(params["id"])
        redirect_if_not_authorized
        erb :"courses/edit"
    end

    private
    def redirect_if_not_authorized
        if @course.user != current_user
            redirect '/courses'
        end
    end

end