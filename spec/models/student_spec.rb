require 'rails_helper'

RSpec.describe Student, type: :model do
  it 'is invalid with empty first_name, empty last_name, and invalid email' do
    student = Student.new(first_name: '', last_name: '', email: '@example.com')
    expect(student).not_to be_valid
  end
end
