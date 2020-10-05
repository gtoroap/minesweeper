class Move < ApplicationRecord
  belongs_to :game

  validate :point_x_valid?
  validate :point_y_valid?

  def point_x_valid?
    if !(0...game.rows).include?(point_x)
      errors.add(:point_x, I18n.t('moves.out_of_range', min: 1, max: game.rows))
    end
  end

  def point_y_valid?
    if !(0...game.columns).include?(point_y)
      errors.add(:point_y, I18n.t('moves.out_of_range', min: 1, max: game.columns))
    end
  end

  def mine_found?
    game.grid[point_x][point_y] == 1
  end
end
