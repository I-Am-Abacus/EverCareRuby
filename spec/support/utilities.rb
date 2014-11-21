include ApplicationHelper
# require '../spec_helper'      << removed when switching rails 4.0.0 > 4.1.0

def cap_sign_in(user)
  # Sign in when using Capybara.
  visit signin_path
  valid_signin(user)
end

def nocap_sign_in(user)
  # Sign in when not using Capybara.
  remember_token = User.new_remember_token
  cookies[:remember_token] = remember_token
  user.sessions.create!(remember_token: User.digest(remember_token))
  # user.update_attribute(:remember_token, User.digest(remember_token))
end

# def scaff_sign_in(user)
#   current_user=user
# end

def valid_signin(user)
  fill_in 'Email',      with: user.email
  fill_in 'Password',   with: user.password
  click_button 'Sign in', match: :first
  # print page
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-danger', text: message)
  end
end

RSpec::Matchers.define :have_success_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-success', text: message)
  end
end

RSpec::Matchers.define :have_notice_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-notice', text: message)
  end
end

RSpec::Matchers.define :have_full_title do |page_id|
  match do |page|
    expect(page).to have_title(full_title(page_id))
  end
end
