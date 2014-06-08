class Organization < ActiveRecord::Base
    include OrganizationsHelper
    # include KanbansHelper
    has_and_belongs_to_many :kanbans

    def org_delete_from_hstore(key)
        delete_from_hstore_string = %(progress = delete("progress", ?))
        self.class.where(id: self.id).update_all([delete_from_hstore_string, key])
    end
end
