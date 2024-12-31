class Question < ApplicationRecord
  validates :content, presence: true
  validates :answer, presence: true, inclusion: { in: %w[A B C D], message: "must be one of 'A', 'B', 'C', or 'D'" }
  validates :options, presence: true

  def options_as_hash
    # Converts options from serialized JSON or text to a Ruby hash
    JSON.parse(options)
  end

  def correct_option
    # Returns the text of the correct answer option
    options_as_hash[answer]
  end
end
