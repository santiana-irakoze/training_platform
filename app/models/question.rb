class Question < ApplicationRecord
  belongs_to :test
  has_many :responses, dependent: :destroy

  validates :content, presence: true
  validates :answer, presence: true
  validates :options, presence: true, if: :multiple_choice?
  validate :answer_in_options, if: :multiple_choice?

  private

  def multiple_choice?
    test&.format == 'Multiple Choice'
  end

  def answer_in_options
    if options.present? && !options.include?(answer)
      errors.add(:answer, "must match one of the options")
    end
  end
end
