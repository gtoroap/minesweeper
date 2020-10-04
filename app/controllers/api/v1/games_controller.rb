module Api
  module V1
    class GamesController < ApplicationController
      def create
        @game = Game.new game_params

        if @game.valid?
          @game.save
          render(status: :ok, json: @game)
        else
          render(status: :bad_request, json: { message: @game.errors.messages })
        end
      end

      private

      def game_params
        params.permit(:rows, :columns, :mines)
      end
    end
  end
end
