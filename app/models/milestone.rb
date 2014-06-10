class Milestone < ActiveRecord::Base
    # validates :organization_id, presence: true
    # validates :kanban_milestone_id, presence: true

    belongs_to :organizations
    belongs_to :kanban_milestone

end
