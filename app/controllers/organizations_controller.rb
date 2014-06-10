class OrganizationsController < ApplicationController
     # before_filter :reset_session
     include OrganizationsHelper

  def index
    @orgs = Organization.all
  end

  def new
    @org = Organization.new
  end

  def create

        current_kanban = session[:current_kanban]

        @org = Organization.new(org_params)

        current_kanban.kanban_milestones.each do |i|
            # @org.milestones.build

            # @org.milestones.attributes = current_kanban.kanban_milestones.attributes

            # @org.milestones.each_with_index do |j, index|
            #     j.milestone_key = i.kms_name
            #     j.milestone_value = "default"
            #     j.kanban_milestone_id = i.id
            # end

            @milestone = Milestone.new
            @milestone.milestone_key = i.kms_name
            @milestone.milestone_value = "default"
            @milestone.kanban_milestone_id = i.id
            @milestone.save
            @org.milestones << @milestone
        end

        @org.kanbans << current_kanban
        if @org.save
            flash[:success] = "Welcome to the Kanban App!"
            redirect_to current_kanban
        else
            render '/organizations/new'
        end

        # # @org.progress = current_kanban.settings
        # @org.kanbans << current_kanban
        # if @org.save
        #     flash[:success] = "Welcome to the Kanban App!"
        #     redirect_to current_kanban
        # else
        #     render '/organizations/new'
        # end
  end

  def show
  end

  def edit
  end

  def update
        current_kanban = session[:current_kanban]

        @org = Organization.find(params[:id])

        if @org.update_attributes(org_params)

            arr = @org.org_columnholder.split(' ')
            key_to_update = arr[0]
            value_to_update = arr[1]

            @org.update_org_progress key_to_update, value_to_update

            @org.org_columnholder = nil

            @org.save


            redirect_to current_kanban
        end

  end

  private
        def org_params
            # params.require(:organization).permit! #(:name, :progress, :org_columnholder)
            params.require(:organization).permit(:name, milestones_attributes: [:id, :milestone_key, :milestone_value])
        end


end
