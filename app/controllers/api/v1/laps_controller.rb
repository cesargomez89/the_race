module Api::V1
  class LapsController < ApplicationController
    before_action :set_race
    before_action :set_car
    before_action :set_participant
    before_action :set_lap, only: %i[ show update destroy ]

    def index
      @laps = @participant.laps

      render json: @laps
    end

    def show
      render json: @lap
    end

    def create
      @lap = @participant.laps.new(lap_params)

      if @lap.save
        render json: @lap, status: :created
      else
        render json: @lap.errors, status: :unprocessable_entity
      end
    end

    def update
      if @lap.update(lap_params)
        render json: @lap
      else
        render json: @lap.errors, status: :unprocessable_entity
      end
    end

    def destroy
      @lap.destroy
    end

    private

    def set_race
      @race = Race.find(params[:race_id])
    end

    def set_car
      @car = @race.cars.find(params[:car_id])
    end

    def set_participant
      @participant = @race.race_participants.find_by!(car_id: @car.id)
    end

    def set_lap
      @lap = @participant.laps.find(params[:id])
    end

    def lap_params
      params.require(:lap).permit(
        :lap_number,
        :start_time,
        :end_time,
      )
    end
  end
end
