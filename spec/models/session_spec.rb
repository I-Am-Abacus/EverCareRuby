require 'spec_helper'

describe Session do

  before do
    @user = FactoryGirl.create(:user)
    # @user = User.new(name: 'Example User', email: 'User@example.com', password: 'foobar', password_confirmation: 'foobar')
    @session = @user.sessions.create(remember_token: 'ABCxyz123')
    temp = 1
  end

  subject { @session }

  describe 'relationships' do
    it { should respond_to(:user) }
  end

  describe 'properties' do
    it { should respond_to(:remember_token) }
  end

  describe 'methods' do
    # it { should respond_to(:get_by_remember_token) }
  end

  describe 'after basic setup' do
    it { should be_valid }
    its(:user) { should eq @user }
  end

end
