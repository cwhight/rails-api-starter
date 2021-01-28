require 'rails_helper'

# Test suite for the Todo model
RSpec.describe Campaign, type: :model do
  # Association test
  # ensure Campaign model has a 1:m relationship with the Item model
  # it { should have_many(:items).dependent(:destroy) }
  # Validation tests
  # ensure columns are present before saving
  it { should validate_presence_of(:first_name) }
  it { should validate_presence_of(:last_name) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:bio) }
end
