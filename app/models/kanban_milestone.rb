class KanbanMilestone < ActiveRecord::Base
    # validates :kms_name, presence: true

    has_one :milestone

    belongs_to :kanban

end
