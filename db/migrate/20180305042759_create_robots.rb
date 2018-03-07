class CreateRobots < ActiveRecord::Migration[5.1]
  def change
    create_table :robots do |t|
      t.integer :pos_x
      t.integer :pos_y
      t.string :direction

      t.timestamps
    end
  end
end
