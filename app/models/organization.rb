class Organization < ActiveRecord::Base
    include OrganizationsHelper
    # include KanbansHelper

    validates :name, :presence => {:message => 'cannot be empty'}

    has_and_belongs_to_many :kanbans

    has_many :milestones, -> {order('id')} # allows to persist that the database records were always sorted by id?

    accepts_nested_attributes_for :milestones, :allow_destroy => true, :update_only => true


    # def org_delete_from_hstore(key)
    #     delete_from_hstore_string = %(progress = delete("progress", ?))
    #     self.class.where(id: self.id).update_all([delete_from_hstore_string, key])
    # end

    def have_milestones_added(value_to_update, k_id)
        @milestone = Milestone.new
        @milestone.milestone_key = value_to_update
        @milestone.milestone_value = "default" if @milestone.milestone_value.nil?
        # @milestone.kanban_milestone_id = k_id

        @milestone.save
        self.milestones << @milestone
    end

end
