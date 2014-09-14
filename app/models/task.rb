class Task < ActiveRecord::Base

    validates :name, :presence => {:message => 'cannot be empty'}
    has_many :taggings
    has_many :kanbans, through: :taggings
    has_many :milestones, -> {order('id')}
    accepts_nested_attributes_for :milestones, :allow_destroy => true

    def have_milestones_added(value_to_update, k_id)
        self.milestones << milestones.build(:milestone_key => value_to_update, :kanban_milestone_id => k_id)
    end

end
