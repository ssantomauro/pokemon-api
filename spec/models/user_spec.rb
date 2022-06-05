require('rails_helper')

RSpec.describe(User, type: :model) do
  # Here I'm not testing the validations as I did for the other Models
  # just because the User model is a model managed by the Devise gem
  # and the behavior is the default one

  describe("associations") do
    it { should have_many(:captures) }
  end

end
