require "rails_helper"

RSpec.feature "Login", focus: true do

  scenario "Creating a download" do
    User.logout!

    visit "/"
    expect(page).to have_content("Test VA Saml")
    fill_in "Email:", with: "xyz@va.gov"
    click_on "Sign In"

    expect(page).to have_current_path("/")
    expect(find("#menu-trigger")).to have_content("First Last")
  end

end
