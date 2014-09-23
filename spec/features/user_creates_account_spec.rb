require 'rails_helper'

feature "User creates an account", %Q{
  As a prospective user
  I want to create an account
  So that I can read and post book reviews

  Acceptance Criteria:

  * I must provide a username, and email address.
  * If I do not provide the required information, I receive an error message.
  * If my email address is already in use, I receive an error message.
  * If password does not match password confirmation, I receive an error message.
  * I must not be logged in to create an account.
  } do

  scenario "with required information" do
    user = FactoryGirl.build(:user)

    visit root_path
    click_on "Sign up"

    fill_in "First name", with: user.first_name
    fill_in "Last name", with: user.last_name
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    fill_in "Password confirmation", with: user.password

    within ".new_user" do
      click_on "Sign up"
    end

    expect(page).to have_content "Welcome! You have signed up successfully."
  end

  scenario "without required information" do
    visit root_path
    click_on "Sign up"

    within ".new_user" do
      click_on "Sign up"
    end

    expect(page).to have_content "First name can't be blank"
    expect(page).to have_content "Last name can't be blank"
    expect(page).to have_content "Email can't be blank"
    expect(page).to have_content "Password can't be blank"
  end

  scenario "email already in use" do
    existing_user = FactoryGirl.create(:user)

    visit root_path
    click_on "Sign up"

    fill_in "First name", with: "Michael"
    fill_in "Last name", with: "Bluth"
    fill_in "Email", with: existing_user.email
    fill_in "Password", with: existing_user.password
    fill_in "Password confirmation", with: existing_user.password

    within ".new_user" do
      click_on "Sign up"
    end

    expect(page).to have_content "Email has already been taken"
  end

  scenario "password confirmation does not match password"

  scenario "user is already logged in" do
    # log in a user
    user = FactoryGirl.create(:user)
    sign_in_as(user)
    # make sure Sign Up button isn't on page
    expect(page).to_not have_content "Sign up"
  end
end
