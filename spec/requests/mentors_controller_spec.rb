require 'rails_helper'

RSpec.describe "Mentors", type: :request do
  describe "GET /mentors" do
    context 'mentors exist' do
      before do
        (1..2).each do |i|
          Mentor.create!(
            first_name: "Mentor#{i}",
            last_name: "Test#{i}",
          )
        end
      end

      it 'returns a page containing all mentor names' do
        get '/mentors'
        expect(response.body).to include('Mentor1')
        expect(response.body).to include('Mentor2')
      end
    end

    context 'mentors do not exist' do
      it 'returns a page with no mentors' do
        get '/mentors'
        expect(response.body).to include('<div id="mentors">')
        expect(response.body).not_to match(/<div.*Mentor.*>/)
      end
    end
  end

  describe "GET /mentors/:id" do
    context 'mentor exists' do
      let!(:mentor) do
        Mentor.create!(
          first_name: "Alice",
          last_name: "Smith",
        )
      end

      it 'returns a page containing the mentor details' do
        get "/mentors/#{mentor.id}"
        expect(response.body).to include('Alice')
        expect(response.body).to include('Smith')
      end
    end

  end
end
