class Kanban < ActiveRecord::Base
    include KanbansHelper
    # include OrganizationsHelper

    # validates :name, presence: true

    has_and_belongs_to_many :organizations

    has_many :kanban_milestones

    accepts_nested_attributes_for :kanban_milestones, :allow_destroy => true

    # def create_kanban_milestone(id)
    #     @kms = KanbanMilestone.new
    #     @kms.kms_name = "col_" + id.to_s
    #     @kms.kanban_id = id
    #     @kms.save
    # end

    # def delete_from_hstore(key)
    #     delete_from_hstore_string = %(settings = delete("settings", ?))
    #     self.class.where(id: self.id).update_all([delete_from_hstore_string, key])
    # end


end
