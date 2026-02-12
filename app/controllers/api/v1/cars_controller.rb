module Api::V1
  class CarsController < ApplicationController
    before_action :set_race
    before_action :set_car, only: %i[ show update destroy ]

    def index
      @cars = @race ? @race.cars : Car.all

      render json: @cars
    end

    def show
      render json: @car
    end

    def create
      @car = if @race
               @race.cars.new(car_params)
             else
               Car.new(car_params)
             end

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
      @race = Race.find(params[:race_id]) if params[:race_id]
    end

    def set_car
      @car = if @race
               @race.cars.find(params[:id])
             else
               Car.find(params[:id])
             end
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
