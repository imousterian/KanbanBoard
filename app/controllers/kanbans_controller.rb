class KanbansController < ApplicationController
    include KanbansHelper


    def index
        @kanbans = Kanban.all
        # @kanbans = Kanban.order(:created_at => :desc)
    end

    def new
        @kanban = Kanban.new
        @kanban.kanban_milestones.build
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
        # 2.times { @kanban.kanban_milestones.build }

        @kanban.kanban_milestones.build

        @kanban.kanban_milestones.each_with_index do |i, index|
            i.kms_name = "col_" + (index+1).to_s
        end

        counter = Kanban.count + 1
        @kanban.name = "Rename me! Kanban # " + counter.to_s

        @kanban.save

        # @kanban.create_kanban_milestone(@kanban.id)

        redirect_to kanbans_path
    end

    def create

        @kanban = Kanban.new(kanban_params)
        @kanban.kanban_milestones.build
        # @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)
        if @kanban.save
            flash[:success] = "Welcome to the Kanban App!"
            redirect_to kanbans_path
        else
            render '/kanbans/new'
        end

    end

    def update

        @kanban = Kanban.find(params[:id])

        if params[:update_columns]
            # @kanban.kanban_milestones.each do |i|

            # end
            logger.debug " params: #{params[:update_attributes]} "
        end

        if @kanban.update_attributes(kanban_params)

            logger.debug " #{kanban_params} "

            # if params[:commit] == 'Save'
            #     @kanban.progress_settings(@kanban.create_key_name, @kanban.columnholder)
            #     @kanban.columnholder = nil
            # end

            # if params[:remove_columns]
            #     if !params[:cols].empty?
            #         key_to_delete = params[:cols]
            #         key_to_delete.each_key do |k|

            #             @kanban.delete_from_hstore(k)

            #             @kanban.organizations.each do |org|
            #                 org.org_delete_from_hstore(k)
            #             end
            #         end
            #     end
            # end

            # update_your_org(@kanban)

            @kanban.save

            redirect_to @kanban

        else
            flash[:error] = "boo"
            redirect_to kanbans_path
        end

    end

    private
        def kanban_params
            # params.require(:kanban).permit! #(:name, :columnholder, :settings)
            # params.require(:kanban).permit(:settings, :name, :columnholder)
            params.require(:kanban).permit(:name, kanban_milestones_attributes: [:id, :kms_name])

        end

end
