# app/controllers/api/v1/laps_controller.rb
module Api
  module V1
    class LapsController < ApplicationController
      before_action :set_participant, only: %i[index create]
      before_action :set_lap, only: %i[show update destroy]

      # GET /race_participants/:race_participant_id/laps
      def index
        laps = @participant.laps.order(:lap_number)
        render json: LapBlueprint.render(laps), status: :ok
      end

      # GET /laps/:id
      def show
        render json: LapBlueprint.render(@lap), status: :ok
      end

      # POST /race_participants/:race_participant_id/laps
      def create
        lap = @participant.laps.create!(lap_params)
        render json: LapBlueprint.render(lap), status: :created
      end

      # PATCH /laps/:id
      def update
        @lap.update!(lap_params)
        render json: LapBlueprint.render(@lap), status: :ok
      end

      # DELETE /laps/:id
      def destroy
        @lap.destroy!
        head :no_content
      end

      private

      def set_participant
        @participant = RaceParticipant.find(params[:race_participant_id])
      end

      def set_lap
        @lap = Lap.find(params[:id])
      end

      def lap_params
        params.require(:lap).permit(
          :lap_number,
          :start_time,
          :end_time,
          :lap_time
        )
      end
    end
  end
end
