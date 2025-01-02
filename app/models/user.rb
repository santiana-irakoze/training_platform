class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :tests, dependent: :nullify
  has_many :responses, dependent: :destroy

  before_destroy :handle_test_cleanup

  private

  def handle_test_cleanup
    # Update all user's tests to remove user association but keep the records
    tests.update_all(user_id: nil, status: 'archived')
  end
end
