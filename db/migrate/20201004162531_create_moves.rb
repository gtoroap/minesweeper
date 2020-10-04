class CreateMoves < ActiveRecord::Migration[6.0]
  def change
    create_table :moves do |t|
      t.integer :point_x
      t.integer :point_y

      t.timestamps
    end
  end
end
