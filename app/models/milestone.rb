class Milestone < ActiveRecord::Base

    # validates :organization_id, presence: true
    # validates :kanban_milestone_id, presence: true

    after_initialize :defaults
    # before_save :set_kms

    belongs_to :organizations
    belongs_to :kanban_milestone



    def update_col_name

        kanban_milestone = KanbanMilestone.where(['id = ? AND kms_name != ?', self.kanban_milestone_id, self.milestone_key]).first
        self.update_column(:milestone_key, kanban_milestone.kms_name) unless kanban_milestone.nil?
    end

    private

        def defaults
            self.milestone_value ||= "default"
        end

        def set_kms
            # kanban_milestone = KanbanMilestone.where(['id = ? AND kms_name != ?', self.kanban_milestone_id, self.milestone_key]).first
            # self.update_column(:milestone_key, kanban_milestone.kms_name) unless kanban_milestone.nil?
        end

end
