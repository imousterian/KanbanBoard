class KanbansController < ApplicationController
    include KanbansHelper


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

        session[:current_kanban] = Hash.new
        @kanban = Kanban.find(params[:id])
        session[:current_kanban] = @kanban

    end


    def default
        @kanban = Kanban.new
        @kanban.name = "Rename me! Kanban # " + (Kanban.count + 1).to_s

        1.upto(2) do |i|
            @kanban.columnholder = "col_" + i.to_s
            @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)
        end

        @kanban.save
        redirect_to kanbans_path
    end

    def create

        @kanban = Kanban.new(kanban_params)
        @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)
        if @kanban.save
            flash[:success] = "Welcome to the Kanban App!"
            redirect_to kanbans_path
        else
            render '/kanbans/new'
        end

    end

    def update

        @kanban = Kanban.find(params[:id])

        if @kanban.update_attributes(kanban_params)

            if params[:commit] == 'Save'
                @kanban.progress_settings(@kanban.create_key_name, @kanban.columnholder)
                @kanban.columnholder = nil
            end

            update_your_org(@kanban)


            @kanban.save

            redirect_to @kanban #kanban_path(@kanban)

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
