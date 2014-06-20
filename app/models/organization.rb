class Organization < ActiveRecord::Base

    validates :name, :presence => {:message => 'cannot be empty'}

    has_and_belongs_to_many :kanbans

    has_many :milestones, -> {order('id')} # allows to persist that the database records were always sorted by id?
    accepts_nested_attributes_for :milestones, :allow_destroy => true #, :update_only => true


    def have_milestones_added(value_to_update, k_id)
        # @milestone = Milestone.new
        # @milestone.milestone_key = value_to_update
        # @milestone.kanban_milestone_id = k_id
        # @milestone.save
        self.milestones << milestones.build(:milestone_key => value_to_update, :kanban_milestone_id => k_id)
    end

end
