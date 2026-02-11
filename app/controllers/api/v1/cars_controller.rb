module Api::V1
  class CarsController < ApplicationController
    def index
      @cars = Car.all

      render json: @cars
    end

    def show
      @car = Car.find(params[:id])

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
      @car = Car.find(params[:id])

      if @car.update(car_params)
        render json: @car
      else
        render json: @car.errors, status: :unprocessable_entity
      end
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
