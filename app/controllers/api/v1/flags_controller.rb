module Api
  module V1
    class FlagsController < ApplicationController
      def create
        @game = Game.find_by(id: flag_params[:game_id])
        return render(status: :bad_request, json: { message: 'Game does not exist' }) unless @game

        @flag = @game.flags.find_by(point_x: flag_params[:point_x], point_y: flag_params[:point_y])

        if @flag
          @flag.save
        else
          @flag = @game.flags.create flag_params
        end
        render(status: :ok, json: @flag)
      end

      private

      def flag_params
        params.permit(:game_id, :point_x, :point_y)
      end
    end
  end
end
