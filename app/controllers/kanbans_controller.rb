class KanbansController < ApplicationController

    before_action :signed_in_user

    def index
        @kanbans = current_user.kanbans
    end

    def new
    end

    def edit
        @kanban = Kanban.find(params[:id])
    end

    def show
        session[:current_kanban] = Hash.new
        @kanban = current_user.kanbans.find_by(id: params[:id])
        session[:current_kanban] = @kanban if !@kanban.nil?
    end

    def default
        @kanban = current_user.kanbans.build
        @kanban.kanban_milestones.build

        @kanban.kanban_milestones.each_with_index do |i, index|
            i.kms_name = "col_" + (index+1).to_s
        end

        counter = current_user.kanbans.count + 1
        @kanban.name = "Rename me! Kanban # " + counter.to_s

        if @kanban.save
            flash[:success] = "New Kanban created!"
            redirect_to root_path
        end

    end

    def destroy
        @kanban.destroy
        flash[:success] = @kanban.name + " destroyed!"
        redirect_to root_path
    end

    def update
        @kanban = current_user.kanbans.find_by(id: params[:id])

        if @kanban.update_attributes(kanban_params)

            d1 = detect_changes
            @kanban.save

            if !d1.empty?
                @value_to_update = d1[0]
                @kanban.tasks.each { |i| i.have_milestones_added(@value_to_update, @kanban.kanban_milestones.last.id) }
            end

            @kanban.tasks.find_each do |p|
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
end












