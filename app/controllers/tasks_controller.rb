class TasksController < ApplicationController

    def new
        @task = Task.new
    end

    def create
        @task = Task.new(task_params)
        current_kanban = session[:current_kanban]
        @task.kanbans << current_kanban
        current_kanban.kanban_milestones.find_each do |p|
            @task.milestones.build(
                :kanban_milestone_id => p.id,
                :milestone_key => p.kms_name
            ) unless p.id.nil?
        end
        if @task.save
            redirect_to current_kanban
        else
            render new_task_path
        end
    end

    def show
        @task = Task.find(params[:id])
    end

    def edit
        @task = Task.find(params[:id])
    end

    def update
        current_kanban = session[:current_kanban]
        @task = Task.find(params[:id])
        if @task.update_attributes(task_params)
            @task.save
            redirect_to current_kanban
        else
            render 'tasks/edit'
        end
    end

    def destroy
        @task = Task.find(params[:id])
        @task.destroy
    end

    private
        def task_params
            params.require(:task).permit(:name, :id, :content, milestones_attributes: [:id, :milestone_key, :milestone_value])
        end

end
