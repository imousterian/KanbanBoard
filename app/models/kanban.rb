class Kanban < ActiveRecord::Base

    belongs_to :user

    default_scope -> { order('created_at DESC') }

#
    validates :name, :presence => {:message => 'cannot be empty'}, :if => "name.blank?", length: {in: 2..20}
    validates :user_id, presence: true


    has_and_belongs_to_many :organizations

    has_many :kanban_milestones, dependent: :destroy

    accepts_nested_attributes_for :kanban_milestones, :allow_destroy => true

end
