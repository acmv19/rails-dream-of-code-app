class Api::V1::EnrollmentsController < ApplicationController


      # 1- static example response
   #def index
    #enrollments_hash = {
      #enrollments: [
        #{
          #id: 1,
          #studentId: 68,
          #studentFirstName: "Bob",
          #studentLastName: "Burger",
         # finalGrade: ""
        #},
        #{
         # id: 2,
        #  studentId: 89,
       #   studentFirstName: "Marge",
      #    studentLastName: "Simpson",
     #     finalGrade: ""
    #    }
   #   ]
  #  }

  #  render json: enrollments_hash, status: :ok
 # end
  
  
  def index
      current_trimester = Trimester.where('start_date <= ? AND end_date >= ?', Date.today, Date.today).first # find current trimester


    course = Course.find_by(id: params[:course_id]) # find course by id
    if course.nil?
      render json: { error: "Course not found" }, status: :not_found
      return
    end

    enrollments = course.enrollments.includes(:student) # bring all enrollments 

    enrollments_array = enrollments.map do |enrollment|
      {
        id: enrollment.id,
        studentId: enrollment.student.id,
        studentFirstName: enrollment.student.first_name,
        studentLastName: enrollment.student.last_name,
        finalGrade: enrollment.final_grade || ""
      }
    end

    render json: { enrollments: enrollments_array }, status: :ok
  end
end