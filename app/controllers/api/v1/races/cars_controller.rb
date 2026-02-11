# POST /races/:race_id/cars/:id
# nested resource for races

module Api::V1
  module Races
    class CarsController < ApplicationController
      before_action :set_race
      before_action :set_car, only: %i[ show update destroy ]

      def index
        @cars = @race.cars

        render json: @cars
      end

      def show
        render json: @car
      end

      def create
        @car = @race.cars.new(car_params)

        if @car.save
          render json: @car, status: :created
        else
          render json: @car.errors, status: :unprocessable_entity
        end
      end

      def update
        if @car.update(car_params)
          render json: @car
        else
          render json: @car.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @car.destroy
      end

      private

      def set_race
        @race = Race.find(params[:race_id])
      end

      def set_car
        @car = @race.cars.find(params[:id])
      end

      def car_params
        params.require(:car).permit(
          :number,
          :team,
          :driver_name
        )
      end
    end
  end
end
