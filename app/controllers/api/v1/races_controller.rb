module Api::V1
  class RacesController < ApplicationController
    before_action :set_race, only: %i[ show update destroy ]

    # GET /races
    def index
      @races = Race.all
      render json: RaceBlueprint.render(@races)
    end

    # GET /races/:id
    def show
      render json: RaceBlueprint.render(@race)
    end

    # POST /races
    def create
      race = Race.create!(race_params)
      render json: RaceBlueprint.render(race), status: :created
    end

    # PATCH /races/:id
    def update
      @race.update!(race_params)
      render json: RaceBlueprint.render(@race)
    end

    # DELETE /races/:id
    def destroy
      @race.destroy!
    end

    private

    def set_race
      @race = Race.find(params[:id])
    end

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
