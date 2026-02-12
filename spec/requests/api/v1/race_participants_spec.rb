require 'swagger_helper'

RSpec.describe 'API V1 Race Participants', type: :request do
  let(:json) { JSON.parse(response.body) }

  path '/api/v1/race_participants' do
    get 'List race participants' do
      tags 'Participants'
      produces 'application/json'

      response '200', 'successful' do
        before { create_list(:race_participant, 3) }

        schema type: :array,
          items: {
            type: :object,
            properties: {
              id: { type: :integer },
              race_id: { type: :integer },
              car_id: { type: :integer },
              created_at: { type: :string, format: :'date-time' },
              updated_at: { type: :string, format: :'date-time' }
            }
          }

        run_test!
      end
    end

    post 'Register car into race' do
      tags 'Participants'
      consumes 'application/json'
      produces 'application/json'

      parameter name: :race_participant, in: :body, schema: {
        type: :object,
        required: [ 'race_participant' ],
        properties: {
          race_participant: {
            type: :object,
            required: %w[race_id car_id],
            properties: {
              race_id: { type: :integer },
              car_id: { type: :integer }
            }
          }
        }
      }

      response '201', 'created' do
        let(:race_participant) do
          {
            race_participant: {
              race_id: create(:race).id,
              car_id: create(:car).id
            }
          }
        end

        run_test!
      end

      response '422', 'invalid request' do
        let(:race_participant) { { race_participant: { race_id: nil } } }
        run_test!
      end
    end
  end

  path '/api/v1/race_participants/{id}' do
    parameter name: :id, in: :path, type: :string

    get 'Show race participant' do
      tags 'Participants'
      produces 'application/json'

      response '200', 'found' do
        let(:record) { create(:race_participant) }
        let(:id) { record.id }

        schema type: :object,
          properties: {
            id: { type: :integer },
            race_id: { type: :integer },
            car_id: { type: :integer },
            created_at: { type: :string, format: :'date-time' },
            updated_at: { type: :string, format: :'date-time' }
          }

        run_test!
      end
    end

    delete 'Remove car from race' do
      tags 'Participants'

      response '204', 'deleted' do
        let(:id) { create(:race_participant).id }
        run_test!
      end
    end
  end
end
