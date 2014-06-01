class Organization < ActiveRecord::Base
    include OrganizationsHelper
    has_and_belongs_to_many :kanbans
end
