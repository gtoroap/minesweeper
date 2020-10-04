module Api
  module V1
    class MovesController < ApplicationController
      def create
        @game = Game.find_by(id: move_params[:game_id])
        return render(status: :bad_request, json: { message: 'Game does not exist' }) unless @game

        @move = @game.moves.build move_params

        if @move.valid?
          @move.save
          render(status: :ok, json: @move)
        else
          render(status: :bad_request, json: { message: @move.errors.messages })
        end
      end

      private

      def move_params
        params.permit(:game_id, :point_x, :point_y)
      end
    end
  end
end
