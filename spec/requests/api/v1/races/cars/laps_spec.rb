require 'rails_helper'

RSpec.describe "Api::V1::Races::Cars::Laps", type: :request do
  let(:race) { create(:race) }
  let(:car) { create(:car) }
  let!(:race_participant) { create(:race_participant, race: race, car: car) }
  let(:valid_attributes) {
    {
      lap_number: 1,
      start_time: Time.current,
      end_time: 1.minute.from_now
    }
  }
  let(:invalid_attributes) {
    {
      lap_number: nil,
      start_time: nil,
      end_time: nil
    }
  }

  describe "GET /index" do
    it "renders a successful response" do
      create(:lap, race_participant: race_participant)
      get api_v1_race_car_laps_url(race, car)
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      lap = create(:lap, race_participant: race_participant)
      get api_v1_race_car_lap_url(race, car, lap)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Lap" do
        expect {
          post api_v1_race_car_laps_url(race, car), params: { lap: valid_attributes }
        }.to change(Lap, :count).by(1)
      end

      it "renders a JSON response with the new lap" do
        post api_v1_race_car_laps_url(race, car), params: { lap: valid_attributes }
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Lap" do
        expect {
          post api_v1_race_car_laps_url(race, car), params: { lap: invalid_attributes }
        }.to change(Lap, :count).by(0)
      end

      it "renders a JSON response with errors for the new lap" do
        post api_v1_race_car_laps_url(race, car), params: { lap: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        { lap_number: 2 }
      }

      it "updates the requested lap" do
        lap = create(:lap, race_participant: race_participant)
        patch api_v1_race_car_lap_url(race, car, lap), params: { lap: new_attributes }
        lap.reload
        expect(lap.lap_number).to eq(2)
      end

      it "renders a JSON response with the lap" do
        lap = create(:lap, race_participant: race_participant)
        patch api_v1_race_car_lap_url(race, car, lap), params: { lap: new_attributes }
        expect(response).to be_successful
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the lap" do
        lap = create(:lap, race_participant: race_participant)
        patch api_v1_race_car_lap_url(race, car, lap), params: { lap: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested lap" do
      lap = create(:lap, race_participant: race_participant)
      expect {
        delete api_v1_race_car_lap_url(race, car, lap)
      }.to change(Lap, :count).by(-1)
    end
  end
end
