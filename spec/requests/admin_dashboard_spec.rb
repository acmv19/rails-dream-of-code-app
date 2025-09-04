require 'rails_helper'

RSpec.describe 'Dashboard', type: :request do
  describe 'GET /dashboard' do
     before do
      @current_trimester = Trimester.create!(
        term: 'Summer',
        year: Date.today.year.to_s,
        start_date: Date.today - 1.day,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 16.days
      )

      @upcoming_trimester = Trimester.create!(
        term: 'fall',
        year: Date.today.year.to_s,
        start_date: Date.today + 2.months,
        end_date: Date.today + 5.months,
        application_deadline: Date.today + 50.days
      )
    end
    it 'returns a 200 OK status' do
      get "/dashboard"

      expect(response).to have_http_status(:ok)
    end

     it 'displays the current trimester' do
      get "/dashboard"
      expect(response.body).to include("Summer")
      end

  it 'displays the upcoming trimester' do
  get "/dashboard"
  expect(response.body).to include("#{@upcoming_trimester.term} - #{@upcoming_trimester.year}")
end
end
end

require 'rails_helper'

RSpec.describe "Courses", type: :request do
  describe "GET /courses/:id" do
    let(:student) { Student.create!(first_name: "ana", last_name: "maldonado", email: "ana1@mail.com") }
    let(:course) do
      coding_class = CodingClass.create!(title: "Ruby on Rails")
      trimester = Trimester.create!(
        term: "Summer",
        year: Date.today.year,
        start_date: Date.today - 1.month,
        end_date: Date.today + 2.months,
        application_deadline: Date.today - 15.days
      )
      course = Course.create!(coding_class: coding_class, trimester: trimester, max_enrollment: 5)
      Enrollment.create!(course: course, student: student)
      course
    end

    it "displays the course and enrolled students" do
      get course_path(course)
      expect(response.body).to include("Ruby on Rails")
      expect(response.body).to include("ana maldonado")
    end
  end
end
