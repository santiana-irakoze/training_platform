class Response < ApplicationRecord
  belongs_to :question
  belongs_to :test
  belongs_to :user, optional: true

  validates :chosen_option, presence: true
  validate :validate_chosen_option, if: -> { question&.test&.format == 'Multiple Choice' }

  private

  def validate_chosen_option
    if question&.options.present? && !question.options.include?(chosen_option)
      errors.add(:chosen_option, "must match one of the available options")
    end
  end
end
