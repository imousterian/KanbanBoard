class UsersController < ApplicationController

    before_action :signed_in_user, only: [:index, :edit, :update, :destroy]
    before_action :correct_user, only: [:edit, :update]
    before_action :admin_user, only: :destroy
    before_filter :signed_in_user_filter, only: [:new, :create]

    def index
        @users = User.all
    end

    def show
        @user = User.find(params[:id])
        # @kanbans = @user.kanbans
    end

    def new
        @user = User.new
    end

    def destroy
        user = User.find(params[:id])
        if (current_user? user) && (current_user.admin_md?)
            flash[:danger] = "Can not delete admin account"
        else
            user.destroy
            flash[:success] = "User deleted."
        end
        redirect_to users_url
    end

    def create
        @user = User.new(user_params)
        if @user.save
            sign_in @user
            redirect_to @user
        else
            # logger.debug "did not work"
            # render 'new'
            render new_user_path
        end
    end

    private
        def user_params
            params.require(:user).permit(:name, :email, :password, :password_confirmation)
        end

        def signed_in_user_filter
            redirect_to root_path, notice: "Already logged in" if signed_in?
        end

        def correct_user
            @user = User.find(params[:id])
            redirect_to root_url unless current_user?(@user)
        end

        def admin_user
            redirect_to(root_url) unless current_user.admin?
        end

end
