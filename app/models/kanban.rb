class Kanban < ActiveRecord::Base
    include KanbansHelper
    # include OrganizationsHelper

    has_and_belongs_to_many :organizations

    has_many :kanban_milestones

    # store_accessor :settings

    def delete_from_hstore(key)
        delete_from_hstore_string = %(settings = delete("settings", ?))
        self.class.where(id: self.id).update_all([delete_from_hstore_string, key])
    end


end
