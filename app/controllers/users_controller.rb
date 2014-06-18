class UsersController < ApplicationController

    def show
        @user = User.find(params[:id])
        # @kanbans = @user.kanbans
    end

    def new
        @user = User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            sign_in @user
            redirect_to @user
        else
            render 'users/new'
        end
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

end
