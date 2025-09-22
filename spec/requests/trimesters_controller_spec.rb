require 'rails_helper'

RSpec.describe "Trimesters", type: :request do
  describe "GET /trimesters" do
    context 'trimesters exist' do
      before do
        (1..2).each do |i|
          Trimester.create!(
            term: "Term #{i}",
            year: '2025',
            start_date: '2025-01-01',
            end_date: '2025-01-01',
            application_deadline: '2025-01-01',
          )
        end
      end

      it 'returns a page containing names of all trimesters' do
        get '/trimesters'
        expect(response.body).to include('Term 1 2025')
        expect(response.body).to include('Term 2 2025')
      end
    end
    context 'trimesters do not exist' do
  it 'returns a page with no trimesters' do
    get '/trimesters'
    expect(response.body).to include('<ul class="trimester-list">') 
    expect(response.body).to match(/<ul class="trimester-list">\s*<\/ul>/)  
      end
    end
  end
  describe "GET /trimesters/:id/edit" do
  let!(:trimester) { Trimester.create!(term: "Fall", year: "2025", start_date: "2025-01-01", end_date: "2025-04-01", application_deadline: "2025-01-01") }

  it "returns the edit form with application deadline label" do
    get edit_trimester_path(trimester)
    expect(response.body).to include("Application deadline")
    expect(response).to have_http_status(:ok)
  end
end

describe "PUT /trimesters/:id" do
  let!(:trimester) { Trimester.create!(term: "Fall", year: "2025", start_date: "2025-01-01", end_date: "2025-04-01", application_deadline: "2025-01-01") }

  it "updates the application deadline when valid" do
    put trimester_path(trimester), params: { trimester: { application_deadline: "2025-02-01" } }
    expect(response).to redirect_to(trimester_path(trimester))
    expect(trimester.reload.application_deadline).to eq(Date.parse("2025-02-01"))
  end

  it "returns 400 when application deadline is missing" do
    put trimester_path(trimester), params: { trimester: { application_deadline: "" } }
    expect(response).to have_http_status(:bad_request)
  end

  it "returns 400 when application deadline is invalid" do
    put trimester_path(trimester), params: { trimester: { application_deadline: "invalid-date" } }
    expect(response).to have_http_status(:bad_request)
  end

  it "returns 404 when trimester does not exist" do
    put "/trimesters/9999", params: { trimester: { application_deadline: "2025-02-01" } }
    expect(response).to have_http_status(:not_found)
  end
end
end