class TestTest < ActiveSupport::TestCase
  belongs_to :user; dependent: :destroy
  has_many :responses

end


