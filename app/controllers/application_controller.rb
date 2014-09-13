class ApplicationController < ActionController::Base
    # Prevent CSRF attacks by raising an exception.
    # For APIs, you may want to use :null_session instead.
    protect_from_forgery with: :exception
    include SessionsHelper
    before_filter :set_cache_buster

    def create_guest_user
        user = User.new
        user.guest = true
        name = "guest_#{Time.now.to_i}#{rand(100)}"
        user.email = "#{name}@example.com"
        user.username = name
        user.password = "guest_#{Time.now.to_i}#{rand(100)}"
        user.password_confirmation = user.password
        user.save!
        sign_in user
        redirect_to root_path
    end

    def set_cache_buster
        response.headers["Cache-Control"] = "no-cache, no-store, max-age=0, must-revalidate"
        response.headers["Pragma"] = "no-cache"
        response.headers["Expires"] = "Fri, 01 Jan 1990 00:00:00 GMT"
    end

end
