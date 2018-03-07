require "rails_helper"

RSpec.describe Robot, type: :model do
  before(:each) do
    @robot = create(:robot)
  end

  subject { @robot }

  context "when associated to a table" do
    it { should validate_presence_of(:table) }
    it { should belong_to(:table) }
  end

  context "when validating position inside table" do
    before(:all) do
      table = create(:table)
      @invalid_robot = build(:robot, :unplaced, pos_x: table.size_x, pos_y: table.size_y, table: table)
    end

    it "should validate x position" do
      expect(@robot.valid?).to be_truthy
      expect(@invalid_robot.valid?).to be_falsey
      expect(@robot.errors.include?(:pos_x)).to be_falsey
      expect(@invalid_robot.errors.include?(:pos_x)).to be_truthy
    end

    it "should validate y position" do
      expect(@robot.valid?).to be_truthy
      expect(@invalid_robot.valid?).to be_falsey
      expect(@robot.errors.include?(:pos_y)).to be_falsey
      expect(@invalid_robot.errors.include?(:pos_y)).to be_truthy
    end
  end

  context "direction" do
    it do
      should validate_inclusion_of(:direction)
        .in_array(["N", "E", "S", "W", nil])
    end
  end

  context "#place" do
    before { @unplaced_robot = create(:robot, :unplaced) }
    it { should respond_to(:place) }

    it "sets robot coordinates and direction" do
      direction = %w[N E S W][Faker::Number.between(0, 3)]
      pos_inside_x = rand(0..@unplaced_robot.table.size_x - 1)
      pos_inside_y = rand(0..@unplaced_robot.table.size_y - 1)
      @unplaced_robot.place(pos_inside_x, pos_inside_y, direction)
      expect(@unplaced_robot.pos_x).to eq(pos_inside_x)
      expect(@unplaced_robot.pos_y).to eq(pos_inside_y)
      expect(@unplaced_robot.direction).to eq(direction)
    end
  end

  context "#move" do
    it { should respond_to(:move) }

    describe "moves robot forward keeping direction" do
      before { @old_position = [@robot.pos_x, @robot.pos_y] }

      it "when facing North" do
        @robot.direction = "N"
        distance = Faker::Number.between(0, @robot.table.size_y - @robot.pos_y - 1)
        @robot.move(distance)
        expect(@robot.pos_y).to eq(@old_position[1] + distance)
      end

      it "when facing South" do
        @robot.direction = "S"
        distance = Faker::Number.between(0, @robot.pos_y - 1)
        @robot.move(distance)
        expect(@robot.pos_y).to eq(@old_position[1] - distance)
      end

      it "when facing East" do
        @robot.direction = "E"
        distance = Faker::Number.between(0, @robot.table.size_x - @robot.pos_x - 1)
        @robot.move(distance)
        expect(@robot.pos_x).to eq(@old_position[0] + distance)
      end

      it "when facing West" do
        @robot.direction = "W"
        distance = Faker::Number.between(0, @robot.pos_x - 1)
        @robot.move(distance)
        expect(@robot.pos_x).to eq(@old_position[0] - distance)
      end
    end

    describe "handles errors" do
      context "when robot is unplaced" do
        before { @unplaced_robot = create(:robot, :unplaced) }
        it "raises an exception" do
          expect { @unplaced_robot.turn("right") }.to raise_error(RuntimeError, "The Robot has not been placed on a table")
        end
      end
    end
  end

  context "#turn" do
    it { should respond_to(:turn) }

    describe "turns robot" do
      before do
        @directions = %w[N E S W]
        @old_index = @directions.index(@robot.direction)
      end

      it "turns left" do
        @robot.turn("left")
        if @old_index != 0
          expect(@directions.index(@robot.direction)).to eq(@old_index - 1)
        else
          expect(@directions.index(@robot.direction)).to eq(@directions.size - 1)
        end
      end

      it "turns left" do
        @robot.turn("right")
        if @old_index != @directions.size - 1
          expect(@directions.index(@robot.direction)).to eq(@old_index + 1)
        else
          expect(@directions.index(@robot.direction)).to eq(0)
        end
      end
    end

    describe "handles errors" do
      context "when robot is unplaced" do
        before { @unplaced_robot = create(:robot, :unplaced) }
        it "raises an exception" do
          expect { @unplaced_robot.turn("right") }.to raise_error(RuntimeError, "The Robot has not been placed on a table")
        end
      end

      context "when wrong side is passed" do
        it "raises an exception" do
          expect { @robot.turn("foobar") }.to raise_error(RuntimeError, "Wrong side selected")
        end
      end
    end
  end
end
