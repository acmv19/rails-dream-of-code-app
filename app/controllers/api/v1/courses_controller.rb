class Api::V1::CoursesController < ApplicationController
  def index
    today = Date.today

    # Find the current trimester
    current_trimester = Trimester.where('start_date <= ? AND end_date >= ?', today, today).first

    courses_data = []
#map over courses only if there is a current trimester  
    if current_trimester
      courses_data = current_trimester.courses.includes(:coding_class).map do |course|
        {
          id: course.id,
          title: course.coding_class.title, 
          application_deadline: course.trimester.application_deadline,
          start_date: course.trimester.start_date,
          end_date: course.trimester.end_date
        }
      end
    end
#return the courses data as JSON
    render json: { courses: courses_data }, status: :ok
  end
end
