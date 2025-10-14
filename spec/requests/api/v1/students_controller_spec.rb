require 'rails_helper'

RSpec.describe "Api::V1::Students", type: :request do
  # --- tests behavior when valid parameters are passed in the post request ---
  describe "POST /api/v1/students" do
    let(:valid_attributes) do
      {
        student: {
          first_name: Faker::Name.first_name,
          last_name: Faker::Name.last_name,
          email: 'validstudent@gmail.com'
        }
      }
    end

    it "creates a new student" do
      expect {
        post '/api/v1/students', params: valid_attributes
      }.to change(Student, :count).by(1)

      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['student']['email']).to eq("validstudent@gmail.com")
    end
  end
  # --- tests behavior when invalid parameters are passed in the post request ---
  describe "POST /api/v1/students" do
    let(:invalid_attributes) do
      {
        student: {
          first_name: '',
          last_name: '',
          email: 'notanemail'
        }
      }
    end

    it "does not create a new student and returns errors" do
      expect {
        post '/api/v1/students', params: invalid_attributes
      }.not_to change(Student, :count)

      expect(response).to have_http_status(:unprocessable_entity)
      expect(JSON.parse(response.body)['errors']).to include("First name can't be blank")
      expect(JSON.parse(response.body)['errors']).to include("Last name can't be blank")
      expect(JSON.parse(response.body)['errors']).to include("Email is invalid")
    end
  end
end
