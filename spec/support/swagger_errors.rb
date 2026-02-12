module SwaggerErrors
  ERROR_SCHEMA = { '$ref' => '#/components/schemas/error' }

  def bad_request_response
    response '400', 'bad request' do
      schema ERROR_SCHEMA

      run_test! do |response|
        body = JSON.parse(response.body)
        expect(body['error']['code']).to eq('bad_request')
      end
    end
  end

  def not_found_response(&block)
    response '404', 'not found' do
      schema ERROR_SCHEMA

      # default fake id (works for most resources)
      let(:id) { -1 }

      instance_eval(&block) if block

      run_test! do |response|
        body = JSON.parse(response.body)
        expect(body['error']['code']).to eq('not_found')
      end
    end
  end

  def conflict_response
    response '409', 'conflict' do
      schema ERROR_SCHEMA

      run_test! do |response|
        body = JSON.parse(response.body)
        expect(body['error']['code']).to eq('conflict')
      end
    end
  end

  def validation_error_response
    response '422', 'validation failed' do
      schema ERROR_SCHEMA

      run_test! do |response|
        body = JSON.parse(response.body)

        expect(body['error']['code']).to eq('validation_failed')
        expect(body['error']['details']).to be_present
      end
    end
  end

  def standard_error_responses
    bad_request_response
    not_found_response
    conflict_response
    validation_error_response
  end
end

RSpec.configure do |config|
  config.extend SwaggerErrors, type: :request
end
