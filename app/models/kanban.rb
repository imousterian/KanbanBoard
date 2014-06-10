class Kanban < ActiveRecord::Base
    include KanbansHelper
    # include OrganizationsHelper

    validates :name, presence: true

    has_and_belongs_to_many :organizations

    has_many :kanban_milestones

    def create_kanban_milestone(id)
        @kms = KanbanMilestone.new
        @kms.kms_name = "col_1"
        @kms.kanban_id = id
        @kms.save
    end

    # def delete_from_hstore(key)
    #     delete_from_hstore_string = %(settings = delete("settings", ?))
    #     self.class.where(id: self.id).update_all([delete_from_hstore_string, key])
    # end


end
