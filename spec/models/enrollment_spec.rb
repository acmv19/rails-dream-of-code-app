require 'rails_helper'

RSpec.describe Enrollment, type: :model do
  describe 'associations' do
    it 'belongs to a course' do
      assoc = Enrollment.reflect_on_association(:course)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it 'belongs to a student' do
      assoc = Enrollment.reflect_on_association(:student)
      expect(assoc.macro).to eq(:belongs_to)
    end

    it 'has many mentor_enrollment_assignments' do
      assoc = Enrollment.reflect_on_association(:mentor_enrollment_assignments)
      expect(assoc.macro).to eq(:has_many)
    end
  end

  describe 'validations' do
    it 'is valid with student and course' do
      student = Student.new(first_name: 'Ana', last_name: 'Maldonado', email: 'ana@gmail.com')
      course = Course.new
      enrollment = Enrollment.new(student: student, course: course)
      expect(enrollment).to be_valid
    end
  end

  describe '#is_past_application_deadline' do
    let(:student) { Student.create!(first_name: 'ana', last_name: 'maldonado', email: 'ana@gmail.com') }
    let(:coding_class) { CodingClass.create!(title: 'Test Class') }
    let(:trimester) do
      Trimester.create!(
        year: '2025',
        term: 'Winter',
        start_date: '2025-01-01',
        end_date: '2025-04-30',
        application_deadline: Date.today
      )
    end
    let(:course) { Course.create!(coding_class: coding_class, trimester: trimester) }

    context 'when enrollment is after the course deadline' do
      it 'returns true' do
        enrollment = Enrollment.create!(student: student, course: course, created_at: Date.today + 1.day)
        expect(enrollment.is_past_application_deadline).to be true
      end
    end

    context 'when enrollment is on or before the deadline' do
      it 'returns false' do
        enrollment = Enrollment.create!(student: student, course: course, created_at: Date.today)
        expect(enrollment.is_past_application_deadline).to be false
      end
    end
  end
end
