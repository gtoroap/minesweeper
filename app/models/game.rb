class Game < ApplicationRecord
  VALID_ROWS_COLUMNS = 10..20
  DEFAULT_ROWS_COLUMNS = 10
  DEFAULT_MINES = 20
  GAME_STATUSES = %w(new started paused resumed won lost)

  validates :rows, :columns, :mines, presence: true
  validates :rows, inclusion: { in: VALID_ROWS_COLUMNS, message: I18n.t('games.default_row_columns') }
  validates :columns, inclusion: { in: VALID_ROWS_COLUMNS, message: I18n.t('games.default_row_columns') }
  validate :total_mines_in_game

  has_many :moves, autosave: true, dependent: :destroy
  has_many :flags, dependent: :destroy

  after_initialize do |game|
    game.rows = DEFAULT_ROWS_COLUMNS if game.rows.nil?
    game.columns = DEFAULT_ROWS_COLUMNS if game.columns.nil?
    game.mines = DEFAULT_MINES if game.mines.nil?
  end

  before_create :set_status_as_new
  before_create :build_grid

  def is_over?
    %w(won lost).include?(status)
  end

  private

  def set_status_as_new
    self.status = 'new'
  end

  def total_mines_in_game
    min = round_nearest_ten(rows * columns * 0.15)
    max = round_nearest_ten(rows * columns * 0.25)

    errors.add(:mines, I18n.t('games.total_mines', min: min, max: max)) unless (min..max).include?(mines)
  end

  def round_nearest_ten(number)
    number.round(-1)
  end

  def build_grid
    self.grid = Array.new(rows) { Array.new(rows) }
    (1..mines).each { randomly_assign_mine }
  end

  def randomly_assign_mine
    empty = true
    while empty
      random_x = rand(0...rows)
      random_y = rand(0...columns)
      if self.grid[random_x][random_y].nil?
        self.grid[random_x][random_y] = Move::MINE_VALUE
        empty = false
      end
    end
  end
end
