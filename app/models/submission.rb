class Submission < ApplicationRecord
  belongs_to :lesson
  belongs_to :mentor, optional: true # mentor can be nil if not yet reviewed
  belongs_to :enrollment
end
