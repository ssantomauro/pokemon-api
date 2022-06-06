require('rails_helper')

RSpec.describe(User, type: :model) do
  # Here I'm only testing the validations for the fields
  # that are not coming from Devise

  subject(:model) do
    described_class.new(email: email, encrypted_password: encrypted_password, api_token: api_token, jti: jti, role: role)
  end

  let(:email) { 'email' }
  let(:encrypted_password) { 'encrypted_password' }
  let(:api_token) { nil }
  let(:jti) { 'jti' }
  let(:role) { 'user' }

  it('is valid with all attributes') do
    expect(model).to be_valid
  end

  context('when the role is not in the ROLES list') do
    let(:role) { 'foo' }

    it('raises a validation error') do
      expect(model).to_not be_valid
    end
  end

  describe('associations') do
    it { should have_many(:captures) }
  end

end
