class OrganizationsController < ApplicationController
     # before_filter :reset_session
     include OrganizationsHelper

      def index
        @orgs = Organization.all
        # @org.milestones.order(:id)
      end

      def new
        @org = Organization.new
      end

  def create

        current_kanban = session[:current_kanban]

        @org = Organization.new(org_params)

        # here I am getting an exra milestone because of the index 0?

        logger.debug " org create: this kanban has #{current_kanban.kanban_milestones.count}"

        l = current_kanban.kanban_milestones.count

        # 1.upto(l) {|o| @org.milestones.build(params[:kanban_milestones]) }
        # 1.upto(l) {|o| @org.milestones.build}

        # current_kanban.kanban_milestones.each { |i| @org.milestones.build(params[:current_kanban]) }

        current_kanban.kanban_milestones.each_entry do |o|
            logger.debug " rest #{o.id} "
        end

        0.upto(l-1) do |i|
            @milestone = Milestone.new
            @milestone.milestone_key = current_kanban.kanban_milestones[i].kms_name
            @milestone.milestone_value = "default"
            @milestone.kanban_milestone_id = current_kanban.kanban_milestones[i].id
            # @milestone.id = i
            @milestone.save
            @org.milestones << @milestone
        end


            # @org.milestones.attributes = current_kanban.kanban_milestones.attributes

            # @org.milestones.each_with_index do |j, index|
            #     j.milestone_key = i.kms_name
            #     j.milestone_value = "default"
            #     j.kanban_milestone_id = i.id
            # end

            # @milestone = Milestone.new
            # @milestone.milestone_key = i.kms_name
            # @milestone.milestone_value = "default"
            # @milestone.kanban_milestone_id = i.id
            # # @milestone.save
            # @org.milestones << @milestone
        # end



        @org.kanbans << current_kanban

        if @org.save
            flash[:success] = "Welcome to the Kanban App!"
            redirect_to current_kanban
        else
            redirect_to current_kanban
            # render '/organizations/new'
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

        @mile = Milestone.find(params[:id])

        logger.debug "#{@mile.id}"
        unless params[:organization][:milestones_attributes].blank?
          for attribute in params[:organization][:milestones_attributes]
            logger.debug " attributes #{attribute}"

            # @org.milestones.sort_by! {|x| x.id}
            # @org.milestones.order!(:milestone_value)
            # @org.update(org_params)

            # @org.save

          end
        end

        if @org.update_attributes(org_params)

            @org.save
        end

        @org.milestones.each do |i|
            logger.debug " milestone id is #{i.id}"
        end


        # if @org.update(org_params)
        #     @org.save

        #     redirect_to current_kanban
        # else
            redirect_to current_kanban
        # end

  end

  private
        def org_params
            # params.require(:organization).permit! #(:name, :progress, :org_columnholder)
            params.require(:organization).permit(:name, :id, milestones_attributes: [:id, :milestone_key, :milestone_value])
        end

        def mile_params
            params.require(:milestone).permit!
        end


end
