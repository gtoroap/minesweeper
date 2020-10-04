class Game < ApplicationRecord
  VALID_ROWS_COLUMNS = 10..20
  DEFAULT_ROWS_COLUMNS = 10
  DEFAULT_MINES = 20

  validates :rows, :columns, :mines, presence: true
  validates :rows, inclusion: { in: VALID_ROWS_COLUMNS, message: I18n.t('games.default_row_columns') }
  validates :columns, inclusion: { in: VALID_ROWS_COLUMNS, message: I18n.t('games.default_row_columns') }
  validate :total_mines_in_game

  has_many :moves

  after_initialize do |game|
    game.rows = DEFAULT_ROWS_COLUMNS if game.rows.nil?
    game.columns = DEFAULT_ROWS_COLUMNS if game.columns.nil?
    game.mines = DEFAULT_MINES if game.mines.nil?
    game.status = 'new'
  end

  private
  def total_mines_in_game
    min = round_nearest_ten(rows * columns * 0.15)
    max = round_nearest_ten(rows * columns * 0.25)

    errors.add(:mines, I18n.t('games.total_mines', min: min, max: max)) unless (min..max).include?(mines)
  end

  def round_nearest_ten(number)
    number.round(-1)
  end
end
