require 'swagger_helper'

RSpec.describe 'API V1 Laps', type: :request do
  let(:json) { JSON.parse(response.body) }

  path '/api/v1/race_participants/{race_participant_id}/laps' do
    parameter name: :race_participant_id, in: :path, type: :string

    get 'List laps for race participant' do
      tags 'Laps'
      produces 'application/json'

      response '200', 'successful' do
        let(:race_participant) { create(:race_participant) }
        let(:race_participant_id) { race_participant.id }

        before { create_list(:lap, 3, race_participant: race_participant) }

        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              lap_number: { type: :integer },
              start_time: { type: :string, format: :'date-time' },
              end_time: { type: :string, format: :'date-time' },
              lap_time: { type: :number },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            }
          }

        run_test!
      end
    end

    post 'Create lap' do
      tags 'Laps'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :lap, in: :body, schema: {
        type: :object,
        required: [ 'lap' ],
        properties: {
          lap: {
            type: :object,
            required: %w[lap_number start_time end_time lap_time],
            properties: {
              lap_number: { type: :integer },
              start_time: { type: :string, format: :'date-time' },
              end_time: { type: :string, format: :'date-time' },
              lap_time: { type: :number }
            }
          }
        }
      }

      response '201', 'created' do
        let(:race_participant) { create(:race_participant) }
        let(:race_participant_id) { race_participant.id }
        let(:lap) { { lap: attributes_for(:lap) } }

        run_test!
      end

      response '422', 'invalid request' do
        let(:race_participant) { create(:race_participant) }
        let(:race_participant_id) { race_participant.id }
        let(:lap) { { lap: { lap_number: nil } } }

        run_test!
      end
    end
  end

  path '/api/v1/laps/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Show lap' do
      tags 'Laps'
      produces 'application/json'

      response '200', 'found' do
        let(:lap_record) { create(:lap) }
        let(:id) { lap_record.id }

        schema type: :object,
          properties: {
            id: { type: :integer },
            lap_number: { type: :integer },
            start_time: { type: :string, format: :'date-time' },
            end_time: { type: :string, format: :'date-time' },
            lap_time: { type: :number },
            created_at: { type: :string, format: :'date-time' },
            updated_at: { type: :string, format: :'date-time' }
          }

        run_test!
      end
    end

    patch 'Update lap' do
      tags 'Laps'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :lap, in: :body, schema: {
        type: :object,
        properties: {
          lap: {
            type: :object,
            properties: {
              lap_time: { type: :number }
            }
          }
        }
      }

      response '200', 'updated' do
        let(:existing_lap) { create(:lap) }
        let(:id) { existing_lap.id }
        let(:lap) { { lap: { lap_time: 123_000 } } }

        run_test!
      end

      response '422', 'invalid update' do
        let(:existing_lap) { create(:lap) }
        let(:id) { existing_lap.id }
        let(:lap) { { lap: { lap_number: nil } } }

        run_test!
      end
    end

    delete 'Delete lap' do
      tags 'Laps'

      response '204', 'deleted' do
        let(:id) { create(:lap).id }
        run_test!
      end
    end
  end
end
