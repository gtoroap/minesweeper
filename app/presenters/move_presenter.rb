class MovePresenter
  attr_reader :move

  def initialize(move)
    @move = move
  end

  def structure
    {
      id: @move.id,
      point_x: @move.point_x,
      point_y: @move.point_y,
      mine_found: @move.mine_found?,
      mines_around: @move.mines_around,
      game_id: @move.game_id,
      possibles_moves: @move.possibles_moves,
      game_status: @move.game.status,
      grid: {
        rows: @move.game.rows,
        columns: @move.game.columns,
        content: @move.game.grid
      }
    }
  end
end
