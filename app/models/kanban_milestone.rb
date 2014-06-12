class KanbanMilestone < ActiveRecord::Base
    # validates :kms_name, presence: true

    has_many :milestones, :dependent => :destroy

    belongs_to :kanban

end
