class UserTest < ActiveSupport::TestCase
  has_many :tests, dependent: :destroy
end
