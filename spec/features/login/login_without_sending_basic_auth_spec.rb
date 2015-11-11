require 'spec_helper'

feature "Login without basic auth" do
  scenario "attempting to hit the main page should raise an error" do
    visit "/"
    expect(page.status_code).to be(401)
  end
end