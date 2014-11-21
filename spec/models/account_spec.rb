require 'spec_helper'

describe Account do

  before do
    @user = User.new(name: 'Example User', email: 'User@example.com', password: 'foobar', password_confirmation: 'foobar')
    @user.save!
    @account = @user.accounts.first
  end

  subject { @account }

  describe 'relationships' do
    it { should respond_to :user }
    it { should respond_to :user_id }
  end

  describe 'properties' do
    it { should respond_to :name }
    it { should respond_to :public }
    it { should respond_to :public? }
    it { should respond_to :status }
    it { should respond_to :initial? }
    it { should respond_to :initial! }
    it { should respond_to :active? }
    it { should respond_to :active! }
    it { should respond_to :suspended? }
    it { should respond_to :suspended! }
  end

  describe 'methods' do
    it { should be_valid }
    it { should respond_to(:display_name) }
  end

  describe 'should have the correct parent user' do
    before do
      @user.save
      @user.accounts.first.save
    end
    it 'value' do
      expect(@account.user).to eq(@user)
    end
  end

  it 'should have the correct values inherited from the parent user' do
    expect(@account.name).to eq('Example User')
    expect(@account).to be_initial
    expect(@account).not_to be_public
  end

  describe 'should inherit updated values if the parent user is changed' do
    before do
      @user.name = 'Changed Name'
      @user.active!
      # @user.save!        # reqd to trigger after_update
      # @user.accounts.first.save!
      # @user.public = true   << public cannot be changed via user. Public is not possible with current state of system
    end
    it 'values' do
      expect(@user.accounts.count).to eq(1)
      expect(@user.accounts.first.name).to eq('Changed Name')
      expect(@user.accounts.first.display_name).to eq('Changed Name')
      expect(@user.accounts.first).to be_active
      # expect(@account).not_to be_public
    end

    describe 'status' do
      describe 'status 1 = initial' do
        before { @user.update! status: 1 }
        it { should be_initial }
      end

      describe 'status 2 = active' do
        before do
          @user.update! status: :active
        end
        it 'status' do
          expect(@user.accounts.first).to be_active
        end
      end

      describe 'status 3 = suspended' do
        before do
          @user.update! status: 3
        end
        it 'status' do
          expect(@user.accounts.first).to be_suspended
        end
      end

      describe 'it should allow the default status to be overridden when creating new' do
        before do
          @user = User.create!(name: 'Example User', email: 'User2@example.com', password: 'foobar', password_confirmation: 'foobar', status: :active)
        end
        it 'status' do
          expect(@user.accounts.first).to be_active
        end

      end
    end
  end

  describe 'updates directly to account, not through user' do
    describe 'name' do
      # describe 'when name is not present', pending: 'only tests user validations at present' do
      describe 'when name is not present' do
        before { @account.name = ' ' }
        it { should_not be_valid }
      end

      # describe 'when name is too long', pending: 'only tests user validations at present' do
      describe 'when name is too long' do
        before { @account.name = 'a' * 51 }
        it { should_not be_valid }
      end
    end

    describe 'public' do
      describe 'should not allow nil' do
        before { @account.public = nil}
        it { should_not be_valid }
      end

      describe 'should allow to set public' do
        before { @account.public = true }
        # it 'public' do
        #   expect(@account.public).to be_true
        # end
        it { should be_public }
      end

      describe 'should allow to unset public' do
        before do
          @account.public = true
          @account.public = false
        end
        # it 'public' do
        #   expect(@account.public).to be_true
        # end
        it { should_not be_public }
      end
    end

    describe 'status' do
      it 'word status should pluralise to statuses' do
        expect('status'.pluralize).to eq 'statuses'
      end

      describe 'enumerator' do
        it 'should not allow zero' do
          expect { @account.update! status: 0 }.to raise_error(ArgumentError)
        end

        it 'should not allow negative' do
          expect { @account.update! status: -1 }.to raise_error(ArgumentError)
        end

        it 'should not allow value too high' do
          expect { @account.update! status: 4 }.to raise_error(ArgumentError)
        end

        describe 'status 1 = initial' do
          before { @user.update! status: 1 }
          it { should be_initial }
        end
      end
    end
  end

  describe 'parent associations' do
    it 'when missing User' do
      expect do
        Account.create!(name: 'test',
                        public: false,
                        status: 1)
      end.to raise_error(ActiveRecord::RecordInvalid, message='Validation failed: User can\'t be blank')
    end
  end

  describe 'child associations' do
    describe 'xxx associations' do

    end

  end
end
