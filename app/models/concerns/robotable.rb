module Robotable
  extend ActiveSupport::Concern

  included do
    include Messages
  end

  module ClassMethods
    def generate_movement_hash(move)
      { axis: move[0], direction: move[1] }
    end
  end

  module Messages
    def self.unplaced_robot
      "The Robot has not been placed on a table"
    end

    def self.wrong_side
      "Wrong side selected"
    end
  end
end
