require 'spec_helper'
# require 'support/utilities'

describe 'Static pages' do

  shared_examples_for 'all static pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_full_title(page_title)}
  end

  subject { page }

  describe 'Home page' do
    before { visit root_path }
    let(:heading)    { 'Emily\'s Edibles'}
    let(:page_title) { '' }

    it_should_behave_like 'all static pages'
    it { should_not have_title('Home') }
    it { should_not have_title('|') }

    describe 'for signed-in users' do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: 'Lorem ipsum')
        FactoryGirl.create(:micropost, user: user, content: 'Dolor sit amet')
        cap_sign_in user
        visit root_path
      end

      it 'should render the users feed', pending: 'there is no longer a user feed on this page' do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content )
        end
      end

      describe 'follower/following counts', pending: 'there is no longer following or follower on this page' do
        let(:other_user) { FactoryGirl.create(:user) }
        before do
          other_user.follow!(user)
          visit root_path
        end
        it { should have_link('0 following', href: following_user_path(user)) }
        it { should have_link('1 followers', href: followers_user_path(user)) }
      end
    end
  end

  describe 'Help page' do
    before { visit help_path }
    let(:heading)    { 'Help'}
    let(:page_title) { 'Help' }

    it_should_behave_like 'all static pages'
  end

  describe 'About page' do
    before { visit about_path }
    let(:heading)    { 'About Us'}
    let(:page_title) { 'About Us' }

    it_should_behave_like 'all static pages'
  end

  describe 'Contact page' do
    before { visit contact_path }
    let(:heading)    { 'Contact Us'}
    let(:page_title) { 'Contact Us' }

    it_should_behave_like 'all static pages'
  end

  it 'should have the right links on the layout' do
    visit root_path
    click_link 'About'
    expect(page).to have_full_title('About Us')
    # click_link 'Help'
    # expect(page).to have_full_title('Help')
    click_link 'Contact'
    expect(page).to have_full_title('Contact Us')
    click_link 'Home'
    click_link 'Sign up now!'
    expect(page).to have_full_title('Sign up')
    click_link 'Emily\'s Edibles'
    expect(page).to have_full_title('')
  end
end