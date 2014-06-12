class KanbanMilestone < ActiveRecord::Base

    validates :kms_name, :presence => {:message => 'Name cannot be empty'}, uniqueness: true

    has_many :milestones, :dependent => :destroy

    belongs_to :kanban

end
