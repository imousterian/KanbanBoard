class Organization < ActiveRecord::Base
    include OrganizationsHelper
    # include KanbansHelper
    has_and_belongs_to_many :kanbans

    has_many :milestones, -> {order('id')} # allows to persist that the database records were always sorted by id?

    accepts_nested_attributes_for :milestones, :allow_destroy => true, :update_only => true



    def org_delete_from_hstore(key)
        delete_from_hstore_string = %(progress = delete("progress", ?))
        self.class.where(id: self.id).update_all([delete_from_hstore_string, key])
    end

end
