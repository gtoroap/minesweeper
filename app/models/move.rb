class Move < ApplicationRecord
  belongs_to :game

  validate :point_x_valid?
  validate :point_y_valid?
  validate :already_played?
  validate :game_over?

  MINE_VALUE = -1

  after_create :possibles_moves

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

  def already_played?
    moves = game.moves.where(point_x: point_x, point_y: point_y)
    if moves.size > 0
      errors.add(:move, I18n.t('moves.already_played'))
    end
  end

  def game_over?
    if game.is_over?
      errors.add(:move, I18n.t('moves.game_over'))
    end
  end

  def mine_found?
    if game.grid[point_x][point_y] == MINE_VALUE
      game.update(status: 'lost')
      true
    else
      false
    end
  end

  def possibles_moves
    possible = 0
    (0...game.rows).each do |row|
      (0...game.columns).each do |col|
        possible += 1 if game.grid[row][col].nil?
      end
    end
    game.update(status: 'won') if possible == 0
  end

  def mines_around
    return - 1 if game.grid[point_x][point_y] == -1

    mines = adjacent_mines(point_x, point_y)
    game.grid[point_x][point_y] = mines
    game.save

    keep_looking_mines(point_x, point_y, []) if mines == 0
    mines
  end

  def adjacent_mines(_x, _y)
    mines = 0
    (_x - 1.._x + 1).each do |i|
      (_y - 1.._y + 1).each do |j|
        next if j < 0 || i < 0 || j > game.columns - 1 || i > game.rows - 1 || _x == i && _y == j
        mines += 1 if game.grid[i][j] == MINE_VALUE
      end
    end
    mines
  end

  def valid_position(_x, _y)
    return true if (_x >= 0 && _y >= 0 && _x <= game.rows - 1 && _y <= game.columns - 1)
    false
  end

  def keep_looking_mines(_x, _y, visited)
    return if visited.include?([_x,_y])

    mines = adjacent_mines(_x, _y)
    visited << [_x,_y]
    game.grid[_x][_y] = mines

    return if mines != 0

    keep_looking_mines(_x - 1, _y - 1, visited) if valid_position(_x - 1, _y - 1)
    keep_looking_mines(_x - 1, _y, visited) if valid_position(_x - 1, _y)
    keep_looking_mines(_x - 1, _y + 1, visited) if valid_position(_x - 1, _y + 1)
    keep_looking_mines(_x, _y - 1, visited) if valid_position(_x, _y - 1)
    keep_looking_mines(_x, _y + 1, visited) if valid_position(_x, _y + 1)
    keep_looking_mines(_x + 1, _y - 1, visited) if valid_position(_x + 1, _y - 1)
    keep_looking_mines(_x + 1, _y, visited) if valid_position(_x + 1, _y)
    keep_looking_mines(_x + 1, _y + 1, visited) if valid_position(_x + 1, _y + 1)

    game.save
  end
end
