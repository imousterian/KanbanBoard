class Kanban < ActiveRecord::Base
    include KanbansHelper

    has_and_belongs_to_many :organizations

    # store_accessor :settings



end
