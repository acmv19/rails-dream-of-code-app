class Submission < ApplicationRecord
  belongs_to :lesson
  belongs_to :mentor
  belongs_to :enrollment
end
