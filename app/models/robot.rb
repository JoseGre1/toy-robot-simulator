class Robot < ApplicationRecord
  include Robotable

  DIRECTIONS = %w[N E S W].freeze
  POSIBLE_MOVEMENTS = [[:pos_y, 1], [:pos_x, 1], [:pos_y, -1], [:pos_x, -1]]
    .map(&(proc { |e| generate_movement_hash(e) })).freeze
  DIRECTION_FACTOR = Hash[DIRECTIONS.zip(POSIBLE_MOVEMENTS)].freeze

  belongs_to :table

  validates :table, presence: true, allow_blank: false, uniqueness: true
  validates :direction,
            inclusion: { in: DIRECTIONS + [nil], message: "Direction is invalid" }
  validate :pos_x_in_range
  validate :pos_y_in_range

  def place(x, y, f)
    self.pos_x = x
    self.pos_y = y
    self.direction = f
    save!
  end

  def move(distance = 1)
    placed_in_table?
    direction = DIRECTION_FACTOR[self.direction][:direction]
    axis = DIRECTION_FACTOR[self.direction][:axis]
    new_position = send(axis) + distance * direction
    send("#{axis}=", new_position)
    save!
  end

  def turn(side)
    placed_in_table?
    current_index = DIRECTIONS.index(direction)
    if side.to_s == "right"
      turn_right(current_index)
    elsif side.to_s == "left"
      turn_left(current_index)
    else
      raise Messages.wrong_side
    end
    save!
  end

  private

  def pos_x_in_range
    pos_in_range(pos_x, table.size_x, :pos_x) if table.present? && pos_x.present?
  end

  def pos_y_in_range
    pos_in_range(pos_y, table.size_y, :pos_y) if table.present? && pos_y.present?
  end

  def pos_in_range(pos, size, attr)
    if pos.negative? || pos >= size
      errors.add(attr, "Position coordinate is not inside table limits")
    end
  end

  def turn_left(current_index)
    self.direction = DIRECTIONS[current_index - 1]
  end

  def turn_right(current_index)
    self.direction = DIRECTIONS[(current_index + 1) % 4]
  end

  def placed_in_table?
    raise Messages.unplaced_robot unless pos_x && pos_y && direction
  end
end
