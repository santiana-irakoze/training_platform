class Test < ApplicationRecord
  belongs_to :user, optional: true
  has_many :responses
  has_many :questions, dependent: :destroy

  # Add scopes for different test types
  scope :templates, -> { where(user_id: nil, status: 'available') }
  scope :attempts, -> { where.not(user_id: nil) }
  scope :taken, -> { attempts.where(status: 'taken') }
  scope :archived, -> { where(status: 'archived') }

  validate :user_presence_for_taken_tests
  validates :format, presence: true, inclusion: { in: ['Multiple Choice', 'Written', 'Mixed'] }
  validates :status, inclusion: { in: ['available', 'taken', 'archived'] }

  # Check if a student has already taken this test template
  def taken_by?(student)
    Test.exists?(
      user_id: student.id,
      Name: self.Name,
      status: 'taken'
    )
  end

  # Find the template version of a test
  def self.find_template(test_name)
    find_by(Name: test_name, user_id: nil, status: 'available')
  end

  private

  def user_presence_for_taken_tests
    if status == "taken" && user.nil?
      errors.add(:user, "must be present for taken tests")
    end
  end

end
