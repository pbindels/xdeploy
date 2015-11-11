module AuthenticatedTestHelper
  def set_basic_auth_header(username)
    Capybara.current_session.driver.header "REMOTE_USER",  username
  end
end