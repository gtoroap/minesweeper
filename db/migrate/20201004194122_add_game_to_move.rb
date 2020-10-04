class AddGameToMove < ActiveRecord::Migration[6.0]
  def change
    add_reference :moves, :game, null: false, foreign_key: true
  end
end
