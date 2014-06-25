class OrganizationsController < ApplicationController

      def index
        @orgs = Organization.all
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
                redirect_to current_kanban
            else
                render new_organization_path
            end

      end

  def show
    @org = Organization.find(params[:id])
  end

  def edit
        # current_kanban = session[:current_kanban]

        @org = Organization.find(params[:id])
  end

  def update

        current_kanban = session[:current_kanban]

        @org = Organization.find(params[:id])

        if @org.update_attributes(org_params)
            @org.save

            redirect_to @org#current_kanban
        else
            render 'organizations/edit'
        end

  end

  private
        def org_params
            params.require(:organization).permit(:name, :id, :content, milestones_attributes: [:id, :milestone_key, :milestone_value])
        end

end
