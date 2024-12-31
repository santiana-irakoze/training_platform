class Response < ApplicationRecord
  belongs_to :question
  belongs_to :test

  validates :is_correct, presence: true
end
