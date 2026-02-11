require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'API V1 Cars', type: :request do
  let(:json) { JSON.parse(response.body) }

  path '/api/v1/cars' do
    get 'List cars' do
      tags 'Cars'
      produces 'application/json'

      response '200', 'successful' do
        before { create_list(:car, 3) }

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

    post 'Create car' do
      tags 'Cars'
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
        let(:car) do
          {
            car: attributes_for(:car)
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:car) { { car: { number: nil } } }

        run_test!
      end
    end
  end

  path '/api/v1/cars/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Show car' do
      tags 'Cars'
      produces 'application/json'

      response '200', 'found' do
        let(:car_record) { create(:car) }
        let(:id) { car_record.id }

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

    patch 'Update car' do
      tags 'Cars'
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
        let(:existing_car) { create(:car) }
        let(:id) { existing_car.id }
        let(:car) { { car: { number: 200 } } }

        run_test!
      end

      response '422', 'invalid update' do
        let(:existing_car) { create(:car) }
        let(:id) { existing_car.id }
        let(:car) { { car: { number: 'two' } } }

        run_test!
      end
    end

    delete 'Delete car' do
      tags 'Cars'

      response '204', 'deleted' do
        let(:id) { create(:car).id }
        run_test!
      end
    end
  end
end
