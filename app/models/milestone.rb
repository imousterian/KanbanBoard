class Milestone < ActiveRecord::Base

    after_initialize :defaults
    belongs_to :tasks
    belongs_to :kanban_milestone

    def update_col_name
        kanban_milestone = KanbanMilestone.where(['id = ? AND kms_name != ?', self.kanban_milestone_id, self.milestone_key]).first
        self.update_column(:milestone_key, kanban_milestone.kms_name) unless kanban_milestone.nil?
    end

    private
        def defaults
            self.milestone_value ||= "default"
        end
end
