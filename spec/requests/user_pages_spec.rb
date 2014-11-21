require 'spec_helper'

describe 'User pages' do

  subject { page }

  describe 'index' do

    let(:user) { FactoryGirl.create(:user) }

    before do
      cap_sign_in user
      visit users_path
    end

    it { should have_full_title('All users') }
    it { should have_content('All users') }

    describe 'pagination' do

      before(:all) do
        3.times { FactoryGirl.create(:user) }
      end
      after(:all)   { User.destroy_all }

      it { should have_selector('div.pagination') }

      it 'should list each user' do
        User.paginate(page: 1).each do |user|
          expect(page).to have_selector('li', text: user.name)
        end
      end
    end

    describe 'delete links' do

      it { should_not have_link('delete') }

      describe 'as an admin user' do
        let(:admin) { FactoryGirl.create(:user_admin) }
        before do
          cap_sign_in admin
          visit users_path
        end

        it { should have_link('delete', href: user_path(User.first)) }
        it 'should be able to delete another user' do
          expect do
            click_link('delete', match: :first)
          end.to change(User, :count).by(-1)
        end
        it { should_not have_link('delete', href: user_path(admin)) }
      end
    end
  end

  describe 'profile page' do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_full_title(user.name) }


  end

  describe 'signup page' do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_full_title('Sign up') }
  end

  describe 'signup' do
    before { visit signup_path }

    let(:submit) { 'Create my account' }          # Submit button

    describe 'with invalid information' do
      it 'should not create a user or account' do
        expect { click_button submit, match: :first }.not_to change(User, :count)
        expect { click_button submit, match: :first }.not_to change(Account, :count)
      end

      describe 'after submission with empty fields' do
        before { click_button submit, match: :first }

        it { should have_full_title('Sign up') }

        it { should have_selector('li', text:'Name can\'t be blank') }
        it { should have_selector('li', text:'Email can\'t be blank') }
        it { should have_selector('li', text:'Email is invalid') }
        it { should have_selector('li', text:'Password can\'t be blank') }
        it { should have_selector('li', text:'Password is too short (minimum is 6 characters')}
      end

      describe 'after submission with invalid email' do
        before do
          fill_in 'Email',     with: 'foobar'
          click_button submit, match: :first
        end

        it { should have_selector('li', text:'Email is invalid') }
      end

      describe 'after submission with mismatched passwords' do
        before do
          fill_in 'Password',     with: 'foobar'
          click_button submit, match: :first
        end

        it { should have_selector('li', text:'Password confirmation doesn\'t match Password') }     # Rails 4.4.4 was: text:'Password confirmation can\'t be blank'
      end
    end

    describe 'with valid information' do
      before do
        fill_in 'Name',         with: 'Example user'
        fill_in 'Email',        with: 'user@example.com'
        fill_in 'Password',     with: 'foobar'
        fill_in 'Confirm Password', with: 'foobar'
      end

      it 'should create a user' do
        expect { click_button submit, match: :first }.to change(User, :count).by(1)
      end

      it 'should create an account' do
        expect { click_button submit, match: :first }.to change(Account, :count).by(1)
      end

      describe 'after saving the user' do
        before { click_button submit, match: :first }
        let(:user) { User.find_by(email: 'user@example.com') }

        it { should have_link('Sign out') }
        it { should have_full_title('') }
        # it { should have_full_title(user.name) }
        it { should have_selector('div.alert.alert-success', text: 'Welcome') }
      end
    end
  end

  describe 'edit' do
    let(:user) { FactoryGirl.create(:user) }
    before do
      cap_sign_in user
      visit(edit_user_path(user))
    end

    describe 'page' do
      it { should have_content('Update your profile') }
      it { should have_full_title('Edit user') }
      it { should have_link('change', href: 'http://gravatar.com/emails') }
    end

    describe 'with invalid information' do
      before { click_button 'Save changes', match: :first }

      it { should have_content('error') }
    end

    describe 'with valid information' do
      let(:new_name)  { 'New Name' }
      let(:new_email) { 'new@example.com' }
      before do
        fill_in 'Name',                   with: new_name
        fill_in 'Email',                  with: new_email
        fill_in 'Password',               with: user.password
        fill_in 'Confirm Password',  with: user.password
        click_button 'Save changes', match: :first
      end

      it { should have_full_title(new_name) }
      it { should have_success_message('Profile updated') }
      it { should have_link('Sign out', href: signout_path) }

      let(:reloaded_user) { user.reload }
      specify { expect(reloaded_user.name).to eq(new_name) }
      specify { expect(reloaded_user.email).to eq(new_email) }
    end

    describe 'forbidden attributes' do
      let(:params) do
        { user: { admin: true, password: user.password, password_confirmation: user.password } }
      end
      before do
        nocap_sign_in user
        patch user_path(user), params
      end
      specify { expect(user.reload).not_to be_admin }
    end
  end

  describe 'following/followers' do
    let(:user) { FactoryGirl.create(:user) }
    let(:other_user) { FactoryGirl.create(:user) }
    before { user.follow!(other_user) }

    describe 'followed users' do
      before do
        cap_sign_in user
        visit following_user_path(user)
      end

      it { should have_full_title('Following') }
      it { should have_selector('h3', text: 'Following') }
      it { should have_link(other_user.name, href: user_path(other_user)) }
    end

    describe 'followers' do
      before do
        cap_sign_in other_user
        visit followers_user_path(other_user)
      end

      it { should have_full_title('Followers') }
      it { should have_selector('h3', text: 'Followers') }
      it { should have_link(user.name, href: user_path(user)) }
    end
  end
end
