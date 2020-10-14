class CreateFlags < ActiveRecord::Migration[6.0]
  def change
    create_table :flags do |t|
      t.integer :point_x
      t.integer :point_y
      t.string :kind
      t.references :game, index: true, foreign_key: true

      t.timestamps
    end
  end
end
