require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'API V1 Races Cars', type: :request do
  path '/api/v1/races/{race_id}/cars' do
    parameter name: :race_id, in: :path, type: :string

    get 'List cars in a race' do
      tags 'Races::Cars'
      produces 'application/json'

      response '200', 'successful' do
        let(:race) { create(:race) }
        let(:race_id) { race.id }
        before { create_list(:race_participant, 3, race: race) }

        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              number: { type: :number },
              team: { type: :string },
              driver_name: { type: :string }
            }
          }

        run_test!
      end
    end

    post 'Add car to race' do
      tags 'Races::Cars'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :car, in: :body, schema: {
        type: :object,
        required: [ 'car' ],
        properties: {
          car: {
            type: :object,
            required: %w[number team driver_name],
            properties: {
              number: { type: :number },
              team: { type: :string },
              driver_name: { type: :string }
            }
          }
        }
      }

      response '201', 'created' do
        let(:race) { create(:race) }
        let(:race_id) { race.id }
        let(:car) { { car: attributes_for(:car) } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:race) { create(:race) }
        let(:race_id) { race.id }
        let(:car) { { car: { number: nil } } }

        run_test!
      end
    end
  end

  path '/api/v1/races/{race_id}/cars/{id}' do
    parameter name: :race_id, in: :path, type: :string
    parameter name: :id, in: :path, type: :string

    get 'Show car in race' do
      tags 'Races::Cars'
      produces 'application/json'

      response '200', 'found' do
        let(:race) { create(:race) }
        let(:race_id) { race.id }
        let(:car) { create(:car) }
        let!(:participant) { create(:race_participant, race: race, car: car) }
        let(:id) { car.id }

        schema type: :object,
          properties: {
            id: { type: :integer },
            number: { type: :number },
            team: { type: :string },
            driver_name: { type: :string }
          }

        run_test!
      end
    end

    patch 'Update car in race' do
      tags 'Races::Cars'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :car, in: :body, schema: {
        type: :object,
        properties: {
          car: {
            type: :object,
            properties: {
              number: { type: :number }
            }
          }
        }
      }

      response '200', 'updated' do
        let(:race) { create(:race) }
        let(:race_id) { race.id }
        let(:car_record) { create(:car) }
        let!(:participant) { create(:race_participant, race: race, car: car_record) }
        let(:id) { car_record.id }
        let(:car) { { car: { number: 999 } } }

        run_test!
      end

      response '422', 'invalid update' do
        let(:race) { create(:race) }
        let(:race_id) { race.id }
        let(:car_record) { create(:car) }
        let!(:participant) { create(:race_participant, race: race, car: car_record) }
        let(:id) { car_record.id }
        let(:car) { { car: { number: 'invalid' } } }

        run_test!
      end
    end

    delete 'Remove car from race' do
      tags 'Races::Cars'

      response '204', 'deleted' do
        let(:race) { create(:race) }
        let(:race_id) { race.id }
        let(:car) { create(:car) }
        let!(:participant) { create(:race_participant, race: race, car: car) }
        let(:id) { car.id }

        run_test!
      end
    end
  end
end
