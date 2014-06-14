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

            @org = Organization.new(org_params)

            current_kanban = session[:current_kanban]

            @org.kanbans << current_kanban

            current_kanban.kanban_milestones.find_each do |p|
                @org.milestones.build(
                        :kanban_milestone_id => p.id,
                        :milestone_key => p.kms_name
                    ) unless p.id.nil?
            end


            # @org.milestones.update

            # current_kanban.kanban_milestones.each { |i| @org.milestones.build(params[:current_kanban]) }

            # l = current_kanban.kanban_milestones.count
            # 0.upto(l-1) do |i|
            #     @milestone = Milestone.new
            #     @milestone.milestone_key = current_kanban.kanban_milestones[i].kms_name
            #     @milestone.milestone_value = "default"
            #     @milestone.kanban_milestone_id = current_kanban.kanban_milestones[i].id

            #     @milestone.save
            #     @org.milestones << @milestone
            # end



            if @org.save
                # flash[:success] = "Welcome to the Kanban App!"
                redirect_to current_kanban
            else
                render new_organization_path
            end

      end

  def show
  end

  def edit
        # current_kanban = session[:current_kanban]

        @org = Organization.find(params[:id])
  end

  def update

        current_kanban = session[:current_kanban]

        @org = Organization.find(params[:id])

        logger.debug " uahaggajshdkfjasdkjshd"

        if @org.update_attributes(org_params)
            @org.save
            redirect_to current_kanban
        else
            render 'organizations/edit'
        end



        # logger.debug "#{@mile.id}"
        # unless params[:organization][:milestones_attributes].blank?
        #   for attribute in params[:organization][:milestones_attributes]
        #     logger.debug " attributes #{attribute}"

        #     # @org.milestones.sort_by! {|x| x.id}
        #     # @org.milestones.order!(:milestone_value)
        #     # @org.update(org_params)

        #     # @org.save

        #   end
        # end



        # @org.milestones.each do |i|
        #     logger.debug " milestone id is #{i.id}"
        # end


        # if @org.update(org_params)
        #     @org.save

        #     redirect_to current_kanban
        # else

        # end

  end

  private
        def org_params
            # params.require(:organization).permit! #(:name, :progress, :org_columnholder)
            params.require(:organization).permit(:name, :id, :content, milestones_attributes: [:id, :milestone_key, :milestone_value])
        end

        def mile_params
            # params.require(:milestone).permit!
        end


end
