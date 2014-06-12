class Kanban < ActiveRecord::Base
    include KanbansHelper
    # include OrganizationsHelper

    # validates :name, presence: true
    validates :name, :presence => {:message => 'cannot be empty'}, length: {in: 2..20}

    has_and_belongs_to_many :organizations

    has_many :kanban_milestones, -> {order('created_at')} # allows to persist that the database records were always sorted by created_at?

    accepts_nested_attributes_for :kanban_milestones, :allow_destroy => true

    # def delete_from_hstore(key)
    #     delete_from_hstore_string = %(settings = delete("settings", ?))
    #     self.class.where(id: self.id).update_all([delete_from_hstore_string, key])
    # end


end
