# require 'rspec'
require 'spec_helper'
# require 'accounts_helper'

# describe 'find_user_account!' do
#   let(:user) { FactoryGirl.create(:user) }
#   let(:user_account) { user.current_account }
#   let(:wrong_user) { FactoryGirl.create(:user) }
#   # before do
#   #   @user = FactoryGirl.create(:user)
#   #   @user_account = @user.current_account
#   #   @wrong_user = FactoryGirl.create(:user)
#   # end
#
#   describe 'when account owned by user' do
#     before do
#       nocap_sign_in user
#     end
#
#     it 'should work' do
#       result = helper.find_user_account!(id: user_account.id)
#       result.should_not be_nil
#       result.should eq user_account
#     end
#   end
#
#   describe 'when account not owned by user' do
#     before do
#       nocap_sign_in wrong_user
#     end
#
#     it 'should error' do
#       expect do
#         helper.find_user_account!(id: user_account.id)
#       end.to raise_error(SecurityError, message='account not known or not allowed for this user')
#     end
#   end
#
#   describe 'when not logged in' do
#     it 'should error' do
#       expect do
#         helper.find_user_account!(id: 1)
#       end.to raise_error(SecurityError, message='not logged in')
#     end
#   end
# end
