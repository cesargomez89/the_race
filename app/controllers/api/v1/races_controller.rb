module Api::V1
  class RacesController < ApplicationController
    def index
      @races = Race.all

      render json: @races
    end

    def show
      @race = Race.find(params[:id])

      render json: @race
    end

    def create
      @race = Race.new(race_params)

      if @race.save
        render json: @race, status: :created
      else
        render json: @race.errors, status: :unprocessable_entity
      end
    end

    def update
      @race = Race.find(params[:id])

      if @race.update(race_params)
        render json: @race
      else
        render json: @race.errors, status: :unprocessable_entity
      end
    end

    private

    def race_params
      params.require(:race).permit(
        :name,
        :track_name,
        :start_time,
        :end_time,
        :start_latitude,
        :start_longitude,
        :finish_latitude,
        :finish_longitude
      )
    end
  end
end
