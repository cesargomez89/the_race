module Api
  module V1
    class RaceParticipantsController < ApplicationController
      before_action :set_participant, only: %i[show destroy]

      # GET /api/v1/race_participants
      def index
        participants = RaceParticipant.order(created_at: :desc)

        render json: RaceParticipantBlueprint.render(participants), status: :ok
      end

      # GET /api/v1/race_participants/:id
      def show
        render json: RaceParticipantBlueprint.render(@participant), status: :ok
      end

      # POST /api/v1/race_participants
      # register car into race
      def create
        participant = RaceParticipant.create!(participant_params)
        render json: RaceParticipantBlueprint.render(participant), status: :created
      end

      # DELETE /api/v1/race_participants/:id
      # remove car from race
      def destroy
        @participant.destroy!
        head :no_content
      end

      private

      def set_participant
        @participant = RaceParticipant.find(params[:id])
      end

      def participant_params
        params.require(:race_participant).permit(:race_id, :car_id)
      end
    end
  end
end
