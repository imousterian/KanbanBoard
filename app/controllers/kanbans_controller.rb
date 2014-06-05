class KanbansController < ApplicationController
    include KanbansHelper
    # include OrganizationsHelper

    # before_filter :reset_session

    def index
        @kanbans = Kanban.all
    end

    def new
        @kanban = Kanban.new

    end

    def edit
        @kanban = Kanban.find(params[:id])
    end

    def show
        # reset_session
        @kanban = Kanban.find(params[:id])
        # @orgs = @kanban.organizations

        session[:current_kanban] = Hash.new
        session[:current_kanban] = @kanban
        # logger.debug " #{@kanban} "
    end

    def default
        @kanban = Kanban.new
        @kanban.name = "Default Kanban # " + (Kanban.count + 1).to_s

        1.upto(2) do |i|
            @kanban.columnholder = "col_" + i.to_s
            @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)
        end

        # flash[:notice] = 'Yay!'

        @kanban.save
        redirect_to kanbans_path
    end

    def create
        # logger.debug " create action"
        @kanban = Kanban.new(kanban_params)
        @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)
        if @kanban.save
            flash[:success] = "Welcome to the MiniTwitter App!"
            redirect_to kanbans_path
        else
            render '/kanbans/new'
        end
    end

    def update
        @kanban = Kanban.find(params[:id])

        if @kanban.update_attributes(kanban_params)

            # @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)

            if params[:commit] == 'Save'
                # logger.debug " @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ "
                @kanban.progress_settings(@kanban.create_key_name, @kanban.columnholder)
            end

            update_your_org(@kanban)

            @kanban.columnholder = nil

            @kanban.save




            redirect_to @kanban #kanban_path(@kanban)
            # redirect_to kanbans_path
        else
            flash[:error] = "boo"
            redirect_to kanbans_path
        end

    end

    private
        def kanban_params
            params.require(:kanban).permit! #(:name, :columnholder, :settings)
            # params.require(:kanban).permit(:settings, :name, :columnholder)

        end

end
