require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  before(:each) do
    visit new_user_path
  end

  scenario 'has a new user page' do
    expect(page).to have_content('Sign Up')
  end

  scenario 'request username and password' do
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

  feature 'signing up a user' do
    scenario 'shows username on the homepage after signup' do
      fill_in "Username", with: "bill nye"
      fill_in "Password", with: "scienceguy"
      click_button 'Sign Up'
      expect(page).to have_content('bill nye')
    end
  end
end

feature 'logging in' do
  before(:each) do
    visit new_session_path
    User.create(username: "Captain Planet", password: "Recycling_is_your_friend" )
  end

  scenario 'has correct login fields' do
    expect(page).to have_content('Username')
    expect(page).to have_content('Password')
  end

  scenario 'signs user in and shows username on the homepage after login' do
    fill_in "Username", with: "Captain Planet"
    fill_in "Password", with: "Recycling_is_your_friend"
    click_button 'Sign In'
    expect(page).to have_content("Captain Planet")
  end
end

feature 'logging out' do
  before(:each) do
    visit new_session_path
    User.create(username: "Captain Planet", password: "Recycling_is_your_friend" )
  end
  scenario 'begins with a logged out state' do
    expect(page).not_to have_content("Sign Out")
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    fill_in "Username", with: "Captain Planet"
    fill_in "Password", with: "Recycling_is_your_friend"
    click_button 'Sign In'
    click_button 'Sign Out'
    expect(page).to_not have_content("Captain Planet")
  end
end
