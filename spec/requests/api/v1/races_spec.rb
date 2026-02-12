require 'swagger_helper'

RSpec.describe 'API V1 Races', type: :request do
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
              start_time: { type: :string, format: :'date-time' },
              end_time: { type: :string, format: :'date-time' },
              start_latitude: { type: :string, example: "38.8951" },
              start_longitude: { type: :string, example: "-77.0364" },
              finish_latitude: { type: :string, example: "38.8951" },
              finish_longitude: { type: :string, example: "-77.0364" },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            }
          }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { example: JSON.parse(response.body) }
          }
        end

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
              start_latitude: { type: :string, example: "38.8951" },
              start_longitude: { type: :string, example: "-77.0364" },
              finish_latitude: { type: :string, example: "38.8951" },
              finish_longitude: { type: :string, example: "-77.0364" }
            }
          }
        }
      }

      response '201', 'created' do
        let(:race) do
          attrs = attributes_for(:race)
          attrs[:start_time] = attrs[:start_time].iso8601
          attrs[:end_time]   = attrs[:end_time].iso8601
          { race: attrs }
        end

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { example: JSON.parse(response.body) }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:race) { { race: { name: nil } } }
        schema '$ref' => '#/components/schemas/error'

        run_test!
      end

      response '400', 'bad request' do
        let(:race) { {} }
        schema '$ref' => '#/components/schemas/error'

        run_test! do |response|
          body = JSON.parse(response.body)
          expect(body['error']['code']).to eq('bad_request')
        end
      end
    end
  end

  path '/api/v1/races/{id}' do
    parameter name: :id, in: :path, type: :integer

    get 'Show race' do
      tags 'Races'
      produces 'application/json'

      response '200', 'found' do
        let(:id) { create(:race).id }

        after do |example|
          example.metadata[:response][:content] = {
            'application/json' => { example: JSON.parse(response.body) }
          }
        end

        run_test!
      end

      response '404', 'not found' do
        let(:id) { 999999 }
        schema '$ref' => '#/components/schemas/error'

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
        let(:id) { create(:race).id }
        let(:race) { { race: { name: 'Updated GP' } } }
        run_test!
      end

      response '422', 'invalid update' do
        let(:id) { create(:race).id }
        let(:race) { { race: { start_latitude: 200 } } }
        schema '$ref' => '#/components/schemas/error'

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
