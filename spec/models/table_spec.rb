require "rails_helper"

RSpec.describe Table, type: :model do
  it { should have_one(:robot) }

  describe "size_x" do
    it do
      should validate_numericality_of(:size_x)
        .is_greater_than_or_equal_to(5)
        .is_less_than_or_equal_to(100)
    end
  end

  describe "size_y" do
    it do
      should validate_numericality_of(:size_y)
        .is_greater_than_or_equal_to(5)
        .is_less_than_or_equal_to(100)
    end
  end
end
