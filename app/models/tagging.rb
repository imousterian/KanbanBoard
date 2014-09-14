class Tagging < ActiveRecord::Base
  belongs_to :task, dependent: :delete
  belongs_to :kanban
end
