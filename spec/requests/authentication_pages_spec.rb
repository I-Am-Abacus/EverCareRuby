require 'spec_helper'
# require 'support/utilities'

# NB this only tests situations where a page should fail to display due to lack of being logged on, or user's lack of authority.


describe 'Authentication' do

  subject { page }

  describe 'signin page' do
    before { visit signin_path }

    it { should have_content 'Sign in' }
    # it { should have_title(full_title('Sign in')) }
    it { should have_full_title('Sign in') }
  end

  describe 'signin' do
    before { visit signin_path }

    describe 'with invalid information' do
      before { click_button 'Sign in', match: :first }

      it { should have_full_title('Sign in') }
      it { should have_error_message('Invalid') }

      describe 'after visiting another page' do
        before { click_link 'Home' }

        it { should_not have_selector('div.alert.alert-danger') }
      end
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        cap_sign_in(user)
        # valid_signin(user)
        # fill_in 'Email',      with: user.email.upcase
        # fill_in 'Password',   with: user.password
        # click_button 'Sign in'
      end

      it { should have_full_title('') }
      # it { should have_full_title(user.name) }
      # it { should have_link('Users',      href: users_path) }
      it { should have_link('Profile',    href: user_path(user)) }
      it { should have_link('Settings',   href: edit_user_path(user)) }
      it { should have_link('Sign out',   href: signout_path) }
      it { should_not have_link('Sign in') }
      it { should have_success_message('Welcome back') }

      describe 'followed by signout' do
        before { click_link 'Sign out' }
        it { should have_link('Sign in')}
      end
    end
  end

  describe 'authorisation' do

    # These are tests for *interventions* by the authorisation process (redirect to signin page if not logged in, etc)

    describe 'for non-signed-in users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'when not signed in' do
        before { visit root_path }
        it { should_not have_link('Profile') }
        it { should_not have_link('Settings') }
        it { should_not have_link('Sign out') }
        it { should have_link('Sign in')}
      end

      describe 'when attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          fill_in 'Email',      with: user.email
          fill_in 'Password',   with: user.password
          click_button 'Sign in', match: :first
        end

        describe 'after signing in' do
          it 'should render the desired protected page' do
            expect(page).to have_full_title('Edit user')
          end
        end

        describe 'after signing in twice' do
          before do
            click_link 'Sign out'
            cap_sign_in(user)
          end

          it 'should render the profile page' do
            expect(page).to have_full_title('')
          end
        end
      end

      describe 'in the Users controller' do

        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }
          it { should have_full_title('Sign in') }
          it { should have_notice_message('Please sign in.') }
        end

        describe 'visiting the user index' do
          before { visit users_path }
          it { should have_title('Sign in') }
        end

        describe 'submitting to the update action' do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end

    end

    describe 'as signed-in user (where user owns the object)' do
      let(:signin_user) { FactoryGirl.create(:user) }

      describe 'in the Users controller' do
        describe 'submitting a GET request to the Users#new action' do
          before do
            nocap_sign_in signin_user
            get new_user_path
          end
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a POST request to the Users#create action' do
          let(:params) do
            { user: { name: signin_user.name, email: signin_user.email, password: signin_user.password, password_confirmation: signin_user.password } }
          end
          before do
            nocap_sign_in signin_user
            post users_path, params
          end
          specify { expect(response).to redirect_to(root_url) }
        end
      end

      # product: no tests required as all are allowed when logged in as the owning user?
      # shopping_list: no tests required as all are allowed when logged in as the owning user?
    end

    describe 'as wrong user (where admin doesn`t matter)' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) do
        FactoryGirl.create(:user, name: 'abc', email: 'wrong@example.com')
      end
      before { nocap_sign_in user }

      describe 'in the Users controller' do
        describe 'submitting a GET request to the Users#edit action' do
          before { get edit_user_path(wrong_user) }
          specify { expect(response.body).not_to match(full_title('Edit user')) }
          specify { expect(response).to redirect_to(root_url) }
        end

        describe 'submitting a PATCH request to the Users#update action' do
          before { patch user_path(wrong_user) }
          specify { expect(response).to redirect_to(root_url) }
        end
      end



    end

    describe 'as wrong user, accessing public account' do
      let(:user) { FactoryGirl.create(:user) }
      let(:product) { FactoryGirl.create(:product_public) }
      # let(:wrong_user) do
      #   FactoryGirl.create(:user, name: 'abc', email: 'wrong@example.com')
      # end
      before { nocap_sign_in user }

    end

    describe 'as non-admin user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { nocap_sign_in non_admin }

      describe 'submitting a DELETE request to the Users#destroy action' do
        before { delete user_path(user) }
        specify { expect(response).to redirect_to(root_url) }
      end

      # notodo no tests for Products controller. All covered above
    end

    describe 'as admin user' do
      # let(:user) { FactoryGirl.create(:user) }
      let(:admin) { FactoryGirl.create(:user_admin) }

      before { nocap_sign_in admin }

      describe 'submitting a DELETE request for self to the Users#destroy action' do
        before { delete user_path(admin) }
        specify { expect(response).to redirect_to(root_url) }
      end

      # product: no tests required as all are allowed when logged in as an admin user?
    end
  end
end
