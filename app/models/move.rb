class Move < ApplicationRecord
  belongs_to :game

  validate :point_x_valid?
  validate :point_y_valid?

  MINE_VALUE = -1

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
    game.grid[point_x][point_y] == MINE_VALUE
  end

  def mines_around
    mines = 0

    (point_y - 1..point_y + 1).each do |j|
      (point_x - 1..point_x + 1).each do |i|
        next if j < 0 || i < 0 || point_x == i && point_y == j
        mines += 1 if game.grid[j][i] == MINE_VALUE
      end
    end

    game.grid[point_x][point_y] = mines
    mines
  end
end
