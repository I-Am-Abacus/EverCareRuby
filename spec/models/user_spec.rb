require 'spec_helper'
# require 'support/utilities'

describe User do

  before do
    @user = User.new(name: 'Example User', email: 'User@example.com', password: 'foobar', password_confirmation: 'foobar')
  end

  subject { @user }

  describe 'relationships' do
    it { should respond_to(:accounts) }
    it { should respond_to(:current_account) }

  end

  describe 'properties' do
    it { should respond_to(:name) }
    it { should respond_to(:email) }
    it { should respond_to(:password_digest) }
    it { should respond_to(:password) }
    it { should respond_to(:password_confirmation) }
    it { should respond_to(:admin) }
    it { should respond_to(:admin?) }
    it { should respond_to(:status) }
    # it { should respond_to(:statuses) }        << thought this should work, from the documentation at http://edgeapi.rubyonrails.org/classes/ActiveRecord/Enum.html
    it { should respond_to(:initial?) }
    it { should respond_to(:initial!) }
    it { should respond_to(:active?) }
    it { should respond_to(:active!) }
    it { should respond_to(:suspended?) }
    it { should respond_to(:suspended!) }
  end

  describe 'methods' do
    it { should respond_to(:authenticate) }
    it { should respond_to(:feed) }
    it { should respond_to(:following?) }
    it { should respond_to(:follow!) }
    it { should respond_to(:display_name) }
  end

  describe 'after basic setup' do
    it { should be_valid }
    it { should_not be_admin }
    it { should be_initial }
    its(:status) { should eq 'initial' }
    its(:current_account) { should be_nil }
    its(:name) { should eq 'Example User'}
    its(:display_name) { should eq 'Example User'}

    it 'should not have an account before save' do
      expect(@user.accounts.first).to be_nil
    end
  end

  describe 'account create triggered by save of user' do
    before { @user.save }

    it 'should now have one account' do
      expect(@user.accounts.first).not_to be_nil
    end

    describe 'new account should be current_account' do
      its(:current_account) { should_not be_nil }
      its(:current_account) { should eq @user.accounts.first }
    end
  end

  describe 'with admin attribute set to true' do
    before do
      @user.save!
      @user.toggle!(:admin)
    end

    it { should be_admin }
    # its(:current_account) { should be_public }    # todo:later
  end

  describe 'name' do
    describe 'when name is not present' do
      before { @user.name = ' ' }
      it { should_not be_valid }
    end

    describe 'when name is too long' do
      before { @user.name = 'a' * 51 }
      it { should_not be_valid }
    end

    describe 'when email is not present' do
      before { @user.email = ' ' }
      it { should_not be_valid }
    end
  end

  describe 'email' do
    describe 'when email format is invalid' do
      it 'should be invalid' do
        addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                     foo@bar_baz.com foo@bar+baz.com foo@bar..com]
        addresses.each do |invalid_address|
          @user.email = invalid_address
          expect(@user).not_to be_valid
        end
      end
    end

    describe 'when email format is valid' do
      it 'should be valid' do
        addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
        addresses.each do |valid_address|
          @user.email = valid_address
          expect(@user).to be_valid
        end
      end
    end

    describe 'when email address is already taken' do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email.upcase!
        user_with_same_email.save
      end

      it { should_not be_valid }

    end

    describe 'when email address is already taken, and matches case set via before_save' do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email.downcase!
        user_with_same_email.save
      end

      it { should_not be_valid }
    end
  end

  describe 'password' do
    describe 'with a password thats too short' do
      before { @user.password_confirmation = @user.password = 'short' }
      it { should_not be_valid }
    end

    describe 'when password is not present' do
      before do
        @user = User.new(name: 'Example User', email: 'User@example.com', password: ' ', password_confirmation: ' ')
      end
      it { should_not be_valid }
    end

    describe 'when password doesnt match confirmation' do
      before { @user.password_confirmation = 'mismatch' }
      it { should_not be_valid }
    end
  end

  describe 'return value of authenticate method' do
    before { @user.save }
    let(:found_user) { User.find_by(email: @user.email) }

    describe 'with valid password' do
      it { should eq found_user.authenticate(@user.password) }
    end

    describe 'with invalid password' do
      let(:user_for_invalid_password) { found_user.authenticate('invalid') }
      it { should_not eq user_for_invalid_password }
      specify { expect(user_for_invalid_password).to be_false }    # Same as "it { :user_for_invalid_password should be_false }"
    end
  end

  describe 'status' do
    it 'word status should pluralise to statuses' do
      expect('status'.pluralize).to eq 'statuses'
    end

    describe 'enumerator' do
      it 'should not allow zero' do
        expect { @user.update! status: 0 }.to raise_error(ArgumentError)
      end

      it 'should not allow negative' do
        expect { @user.update! status: -1 }.to raise_error(ArgumentError)
      end

      it 'should not allow value too high' do
        expect { @user.update! status: 4 }.to raise_error(ArgumentError)
      end

      describe 'status 1 = initial' do
        before { @user.update! status: 1 }
        it { should be_initial }
      end

      describe 'status 2 = active' do
        before { @user.update! status: 2 }
        it { should be_active }
      end

      describe 'status 3 = suspended' do
        before { @user.update! status: 3 }
        it { should be_suspended }
      end
    end

    describe 'it should allow the default status to be overridden when creating new' do
      before do
        @user = User.new(name: 'Example User', email: 'User@example.com', password: 'foobar', password_confirmation: 'foobar', status: :active)
      end
      it 'status' do
        expect(@user).to be_active
      end

    end
  end

  describe 'child associations' do
    describe 'account associations' do

    end

  end
end
