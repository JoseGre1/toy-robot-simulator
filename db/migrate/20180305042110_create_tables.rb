class CreateTables < ActiveRecord::Migration[5.1]
  def change
    create_table :tables do |t|
      t.integer :size_x
      t.integer :size_y

      t.timestamps
    end
  end
end
