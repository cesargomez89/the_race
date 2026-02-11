require 'rails_helper'
require 'swagger_helper'

RSpec.describe 'API V1 Races', type: :request do
  let(:json) { JSON.parse(response.body) }

  path '/api/v1/races' do
    get 'List races' do
      tags 'Races'
      produces 'application/json'

      response '200', 'successful' do
        before { create_list(:race, 3) }

        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              name: { type: :string },
              track_name: { type: :string },
              start_time: { type: :string },
              end_time: { type: :string },
              start_latitude: { type: :string, format: :decimal },
              start_longitude: { type: :string, format: :decimal },
              finish_latitude: { type: :string, format: :decimal },
              finish_longitude: { type: :string, format: :decimal }

            }
          }

        run_test!
      end
    end

    post 'Create race' do
      tags 'Races'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :race, in: :body, schema: {
        type: :object,
        required: [ 'race' ],
        properties: {
          race: {
            type: :object,
            required: %w[name track_name start_time end_time start_latitude start_longitude finish_latitude finish_longitude],
            properties: {
              name: { type: :string },
              track_name: { type: :string },
              start_time: { type: :string, format: :'date-time' },
              end_time: { type: :string, format: :'date-time' },
              start_latitude: { type: :string, format: :decimal },
              start_longitude: { type: :string, format: :decimal },
              finish_latitude: { type: :string, format: :decimal },
              finish_longitude: { type: :string, format: :decimal }
            }
          }
        }
      }

      response '201', 'created' do
        let(:race) do
          {
            race: attributes_for(:race)
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:race) { { race: { name: nil } } }

        run_test!
      end
    end
  end

  path '/api/v1/races/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Show race' do
      tags 'Races'
      produces 'application/json'

      response '200', 'found' do
        let(:race_record) { create(:race) }
        let(:id) { race_record.id }

        schema type: :object,
          properties: {
            id: { type: :integer },
            name: { type: :string },
            track_name: { type: :string },
            start_time: { type: :string },
            end_time: { type: :string },
            start_latitude: { type: :string, format: :decimal },
            start_longitude: { type: :string, format: :decimal },
            finish_latitude: { type: :string, format: :decimal },
            finish_longitude: { type: :string, format: :decimal }
          }

        run_test!
      end
    end

    patch 'Update race' do
      tags 'Races'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :race, in: :body, schema: {
        type: :object,
        properties: {
          race: {
            type: :object,
            properties: {
              name: { type: :string }
            }
          }
        }
      }

      response '200', 'updated' do
        let(:existing_race) { create(:race) }
        let(:id) { existing_race.id }
        let(:race) { { race: { name: 'Updated GP' } } }

        run_test!
      end

      response '422', 'invalid update' do
        let(:existing_race) { create(:race) }
        let(:id) { existing_race.id }
        let(:race) { { race: { start_latitude: 200 } } }

        run_test!
      end
    end

    delete 'Delete race' do
      tags 'Races'

      response '204', 'deleted' do
        let(:id) { create(:race).id }
        run_test!
      end
    end
  end
end
