class KanbansController < ApplicationController
    # include KanbansHelper
    before_action :signed_in_user#, only: [:create, :destroy] - chapter 10, doublecheck later

    def index
        @kanbans = Kanban.all
        # @kanbans = Kanban.order(:created_at => :desc)
    end

    def new
        # @kanban = Kanban.new
        # @kanban.kanban_milestones.build
    end

    def edit
        @kanban = Kanban.find(params[:id])
    end

    def show

        session[:current_kanban] = Hash.new
        @kanban = current_user.kanbans.find_by(id: params[:id])#Kanban.find(params[:id])
        session[:current_kanban] = @kanban

        # logger.debug " show: this kanban has #{@kanban.kanban_milestones.count}"

    end


    def default

        @kanban = current_user.kanbans.build#Kanban.new

        @kanban.kanban_milestones.build

        @kanban.kanban_milestones.each_with_index do |i, index|
            i.kms_name = "col_" + (index+1).to_s
        end

        counter = current_user.kanbans.count + 1#Kanban.count + 1
        @kanban.name = "Rename me! Kanban # " + counter.to_s

        if @kanban.save
            flash[:success] = "New Kanban created!"
            redirect_to root_path #current_user #kanbans_path
        end

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

    def destroy
        delete_organizations
        @kanban.destroy
        redirect_to root_path
    end

    def update

        # @kanban = Kanban.find(params[:id])
        @kanban = current_user.kanbans.find_by(id: params[:id])

        if @kanban.update_attributes(kanban_params)

            d1 = detect_changes

            # not needed?
            # if params[:delete_columns]
            #     to_delete = params[:kanban][:kanban_milestones_attributes].collect { |i, att| att[:id] if (att[:id] && att[:_destroy].to_i == 1) }
            #     KanbanMilestone.delete(to_delete)
            # end
            # logger.debug " 1: changed? params #{@kanban.changed} "
            @kanban.save
            # if params[:add_column]
            #     # @value_to_update = params[:kanban][:kanban_milestones_attributes].values[0].values[0]
            #     # @kanban.organizations.each { |i| i.have_milestones_added(@value_to_update, @kanban.kanban_milestones.last.id) }
            #     # test: {"kanban_milestones_attributes"=>{"0"=>{"kms_name"=>"er"}}}
            # end

            # adds a new column
            if !d1.empty?
                @value_to_update = d1[0]
                @kanban.organizations.each { |i| i.have_milestones_added(@value_to_update, @kanban.kanban_milestones.last.id) }
            end


            # updates names of milestones in organizations as per kanban_milestones.
            # need to do it automatically - change the architecture?

            @kanban.organizations.find_each do |p|
                p.milestones.find_each { |d| d.update_col_name }
            end

            flash[:success] = "Kanban updated!"

            redirect_to @kanban and return
        else
            render 'kanbans/edit'
        end

    end

    private
        def kanban_params
            params.require(:kanban).permit(:name, kanban_milestones_attributes: [:id, :kms_name, :_destroy] )
        end

        def detect_changes
          @changed = []

          lists = params[:kanban][:kanban_milestones_attributes]
            lists.each do |i|
                @changed << i[1].fetch(:kms_name) if i[1].has_key?(:id) == false
            end
            @changed
        end

        def delete_organizations
            @kanban = current_user.kanbans.find_by(id: params[:id])
            @kanban.organizations.find_each {|i| i.destroy }
        end
end












