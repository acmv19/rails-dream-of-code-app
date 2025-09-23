class SubmissionsController < ApplicationController
   # only students can create new submissions
  before_action :require_student, only: [:new, :create]
  # only mentors can edit and update submissions
  before_action :require_mentor, only: [:edit, :update]
  # GET /submissions/new
  def new
    @course = Course.find(params[:course_id])
    @submission = Submission.new

    @enrollments = @course.enrollments.includes(:student) # to show student names in the dropdown
    @lessons = @course.lessons    # to show lesson titles in the dropdown
  end

  def create
    @course = Course.find(params[:course_id])
    @submission = Submission.new(submission_params)

    if @submission.save
      redirect_to course_path(@course), notice: 'Submission was successfully created.'
    else
     @enrollments = @course.enrollments.includes(:student) # to show student names in the dropdown
    @lessons = @course.lessons# to show lesson titles in the dropdown
    render :new
    end
  end

  # GET /submissions/1/edit
  def edit
     @submission = Submission.find(params[:id])
    @course = @submission.lesson.course
    @enrollments = @course.enrollments.includes(:student)
    @lessons = @course.lessons
  end

  # PATCH/PUT /submissions/1 or /submissions/1.json
  def update
    @submission = Submission.find(params[:id])
    @course = @submission.lesson.course

    if @submission.update(submission_params)
      redirect_to course_path(@course), notice: 'Submission was successfully updated.'
    else
      @enrollments = @course.enrollments.includes(:student)
      @lessons = @course.lessons
      render :edit
    end
  end

   # GET /submissions
  def index
    # only mentors can see all submissions
    @submissions = Submission.all.includes(:lesson, :enrollment)
  end

  private
    # Only allow a list of trusted parameters through.
    def submission_params
  params.require(:submission).permit(:lesson_id, :enrollment_id, :mentor_id, :review_result, :reviewed_at, :pull_request_url)
end

end
