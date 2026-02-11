module Api::V1
  class CarsController < ApplicationController
    before_action :set_car, only: %i[ show update destroy ]

    def index
      @cars = Car.all

      render json: @cars
    end

    def show
      render json: @car
    end

    def create
      @car = Car.new(car_params)

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

    def car_params
      params.require(:car).permit(
        :number,
        :team,
        :driver_name
      )
    end
  end
end
