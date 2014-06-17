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

        logger.debug " uahaggajshdkfjasdkjshd   "

        if @org.update_attributes(org_params)
            @org.save

            logger.debug " --- uahaggajshdkfjasdkjshd  --- "

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

end
