module AuthenticationMacros

  def background_basic_login
    background do
      @name = Forgery(:name).first_name
      if Capybara.current_driver == :rack_test
        Capybara.current_session.driver.header "REMOTE_USER",  @name
      else
        Capybara.current_session.driver.headers = {"REMOTE_USER" => @name}
      end
    end
  end

  def before_each_basic_login
    before(:each) do
      @username = Forgery(:name).first_name
      @request.env['REMOTE_USER'] = @username
    end
  end
  
end