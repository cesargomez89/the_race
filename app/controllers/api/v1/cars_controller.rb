module Api::V1
  class CarsController < ApplicationController
    before_action :set_car, only: %i[ show update destroy ]

    # GET /cars
    def index
      @cars = Car.all
      render json: CarBlueprint.render(@cars)
    end

    # GET /cars/:id
    def show
      render json: CarBlueprint.render(@car)
    end

    # POST /cars
    def create
      car = Car.create!(car_params)
      render json: CarBlueprint.render(car), status: :created
    end

    # PATCH /cars/:id
    def update
      @car.update!(car_params)
      render json: CarBlueprint.render(@car)
    end

    # DELETE /cars/:id
    def destroy
      @car.destroy!
    end

    private

    def set_car
      @car = Car.find(params[:id])
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
