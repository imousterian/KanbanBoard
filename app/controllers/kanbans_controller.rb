class KanbansController < ApplicationController
    include KanbansHelper


    def index
        @kanbans = Kanban.all
        @kanbans = Kanban.order(:created_at => :desc)
    end

    def new
        @kanban = Kanban.new
        # @kanban.kanban_milestones.build
    end

    def edit
        @kanban = Kanban.find(params[:id])
    end

    def show

        session[:current_kanban] = Hash.new
        @kanban = Kanban.find(params[:id])
        session[:current_kanban] = @kanban

        logger.debug " show: this kanban has #{@kanban.kanban_milestones.count}"

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

        flash[:success] = "New Kanban created!"

        redirect_to kanbans_path
    end

    def create

        # @kanban = Kanban.new(kanban_params)
        # @kanban.kanban_milestones.build
        # # @kanban.progress_settings(@kanban.columnholder, @kanban.columnholder)
        # if @kanban.save
        #     flash[:success] = "Welcome to the Kanban App!"
        #     redirect_to kanbans_path
        # else
        #     render '/kanbans/new'
        # end

    end

    def update

        @kanban = Kanban.find(params[:id])

        logger.debug "!!! @@@@@kanban params@@@@@@ #{kanban_params}"

        if @kanban.update_attributes(kanban_params)
            logger.debug " #{@kanban.attributes} "

            # not needed?
            # if params[:delete_columns]
            #     to_delete = params[:kanban][:kanban_milestones_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
            #     KanbanMilestone.delete(to_delete)
            # end

            @kanban.save

            if params[:add_column]
                @value_to_update = params[:kanban][:kanban_milestones_attributes].values[0].values[0]
                @kanban.organizations.each { |i| i.have_milestones_added(@value_to_update, @kanban.kanban_milestones.last.id) }
                # test: {"kanban_milestones_attributes"=>{"0"=>{"kms_name"=>"er"}}}
            end

            # @organizations = @kanban.organizations.find_by(kanban_id: params[:id])
            # @biz = Milestone.find_or_create_by_name(params[:milestone_key])
            # @micropost = current_user.microposts.find_by(id: params[:id])

            # logger.debug " #{@biz} "


            flash[:success] = "Kanban updated!"

            logger.debug " @@@@@kanban params@@@@@@ #{kanban_params}"

            # updates names of milestones in organizations as per kanban_milestones.
            # need to do it automatically - change the architecture?

            @kanban.organizations.find_each do |p|
                p.milestones.find_each { |d| d.update_col_name }
            end

            redirect_to @kanban and return
        else
            render 'kanbans/edit'
        end

    end

    private
        def kanban_params
            # params.require(:kanban).permit! #(:name, :columnholder, :settings)
            # params.require(:kanban).permit(:settings, :name, :columnholder)
            params.require(:kanban).permit(:name, kanban_milestones_attributes: [:id, :kms_name, :_destroy] )

        end

end
