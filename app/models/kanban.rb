class Kanban < ActiveRecord::Base
    # include ActiveRecord::Base
    # include ActiveModel::AttributeMethods
    # include ActiveModel::Dirty
    #include KanbansHelper
    # include OrganizationsHelper

    # define_attribute_methods :name#, :kanban_milestones

    belongs_to :user

    default_scope -> { order('created_at DESC') }

#
    validates :name, :presence => {:message => 'cannot be empty'}, :if => "name.blank?", length: {in: 2..20}
    validates :user_id, presence: true


    has_and_belongs_to_many :organizations

    has_many :kanban_milestones, -> {order('created_at')} # allows to persist that the database records were always sorted by created_at?

    accepts_nested_attributes_for :kanban_milestones, :allow_destroy => true

    # def delete_from_hstore(key)
    #     delete_from_hstore_string = %(settings = delete("settings", ?))
    #     self.class.where(id: self.id).update_all([delete_from_hstore_string, key])
    # end

      #   def name
      #   @name
      # end

      # def name=(val)
      #   name_will_change! unless val == @name
      #   @name = val
      # end

end
