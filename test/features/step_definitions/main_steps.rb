#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

Before do |scenario|
  tags = scenario.instance_variable_get(:@tags).to_sexp.map { |tag_info| tag_info[1] }
  @use_javascript = tags.include?('@javascript')
  @trap_alerts = tags.include?('@trap_alerts')
  @set_callbacks = tags.include?('@set_callbacks')
end

After do
  if @config_modified
    # Reset the config
    visit '/configure?main_container=Content&flash_container_notice=FlashNotice&flash_container_alert=FlashAlert&flash_container_error=FlashError'
  end
end

After('@set_callbacks') do
  page.execute_script('window.cancelNextBeforeSend = false;')
  page.evaluate_script('window.getNextCallback();').should be_nil
end

After('@trap_alerts') do
  # Check that all alerts have been trapped
  page.execute_script('window.alert = window.originalAlert;')
  page.evaluate_script('window.getNextAlertMessage();').should be_nil
end

Given /^I am on the home page$/ do
  visit root_path
  if @trap_alerts
    page.execute_script('
      window.alertMessages = [];
      window.originalAlert = window.alert;
      window.alert = function(iMessage) {
        window.alertMessages[window.alertMessages.length] = iMessage;
      };
      window.getNextAlertMessage = function() {
        var lResult = window.alertMessages[0];
        window.alertMessages.splice(0, 1);
        return lResult;
      };
    ')
  end
  if @set_callbacks
    page.execute_script('
      window.callbacksCalled = [];
      window.cancelNextBeforeSend = false;
      railsAjax.beforeSend = function(ioXHR, iSettings) {
        console.log(\'***************************** beforeSend BEGIN\');
        window.callbacksCalled[window.callbacksCalled.length] = \'beforeSend\';
        console.log(\'***************************** beforeSend END\');
        return !window.cancelNextBeforeSend;
      };
      railsAjax.success = function(iXHR, iData) {
        console.log(\'***************************** success BEGIN\');
        window.callbacksCalled[window.callbacksCalled.length] = \'success\';
        console.log(\'***************************** success END\');
      };
      railsAjax.error = function(iXHR, iError) {
        console.log(\'***************************** error BEGIN\');
        window.callbacksCalled[window.callbacksCalled.length] = \'error\';
        console.log(\'***************************** error END\');
      };
      railsAjax.complete = function(iXHR) {
        console.log(\'***************************** complete BEGIN\');
        window.callbacksCalled[window.callbacksCalled.length] = \'complete\';
        console.log(\'***************************** complete END\');
      };
      window.getNextCallback = function() {
        var lResult = window.callbacksCalled[0];
        window.callbacksCalled.splice(0, 1);
        return lResult;
      };
    ')
  end
end

Given /^I setup flash container "(.*?)" to "(.*?)"$/ do |iFlashType, iContainerID|
  visit "/configure?flash_container_#{iFlashType}=#{iContainerID}"
  @config_modified = true
end

Given /^I setup the main container to "(.*?)"$/ do |iContainerID|
  visit "/configure?main_container=#{iContainerID}"
  @config_modified = true
end

Given /^I mark the next Ajax call to be cancelled$/ do
  page.execute_script('window.cancelNextBeforeSend = true;')
end

Given(/^I register user "(.*?)" with password "(.*?)"$/) do |user_email, user_password|
  visit new_user_registration_path
  fill_in('Email', :with => user_email)
  fill_in('Password', :with => user_password)
  fill_in('Password confirmation', :with => user_password)
  click_on('Sign up')
end

Given(/^I register user "(.*?)" with unmatched passwords "(.*?)" and confirmation "(.*?)"$/) do |user_email, user_password, user_password_confirmation|
  visit new_user_registration_path
  fill_in('Email', :with => user_email)
  fill_in('Password', :with => user_password)
  fill_in('Password confirmation', :with => user_password_confirmation)
  click_on('Sign up')
end

Given(/^User "(.*?)" is registered with password "(.*?)"$/) do |user_email, user_password|
  FactoryGirl.create(:user, :email => user_email, :password => user_password, :password_confirmation => user_password)
end

When(/^I sign in user "(.*?)" with password "(.*?)"$/) do |user_email, user_password|
  visit new_user_session_path
  fill_in('Email', :with => user_email)
  fill_in('Password', :with => user_password)
  click_on('Sign in')
end

When /^I click on "(.*?)" from "(.*?)"$/ do |iLinkName, iContextName|
  click_link("Go to #{iLinkName} from #{iContextName}")
end

When /^I submit "([^"]*?)" using "([^"]*?)"$/ do |iTextValue, iButtonName|
  # Find the button first, before filling in the text field, as otherwise the driver could fill the previous text field if the Ajax call did not return the new page fast enough.
  lButton = find_button(iButtonName)
  all(:field, 'Text field').each do |ioElement|
    ioElement.set(iTextValue)
  end
  lButton.click
end

When /^I submit "([^"]*?)" in "([^"]*?)" using "([^"]*?)"$/ do |iTextValue, iFieldName, iButtonName|
  fill_in(iFieldName, :with => iTextValue)
  click_on(iButtonName)
end

When /^I go back "(.*?)" times in history$/ do |iNbrTimes|
  iNbrTimes.to_i.times do |iIdx|
    # TODO: Remove this sleep when Capybara-webkit will handle history correctly. Test on Travis.
    sleep 5
    page.execute_script('window.history.back();')
  end
end

When /^I wait for "(.*?)"$/ do |iPageName|
  page.should have_selector("div##{iPageName}")
end

When /^I manually enter URL "(.*?)"$/ do |iURL|
  visit(iURL)
end

When(/^I make the Ajax call number "(.*?)"$/) do |iNbr|
  click_link("json#{iNbr}_link")
end

When(/^I make the Ajax form call number "(.*?)"$/) do |iNbr|
  click_button("json#{iNbr}_button")
end

Then(/^nobody should be signed in$/) do
  # Check there is no current user
  find("div#logged_in_user").should have_content("None")
end

Then(/^the mismatched passwords error should be displayed$/) do
  find("div#error_explanation").should have_content((ENV['RAILS_VERSION'] == '3') ? 'Password doesn\'t match confirmation' : 'Password confirmation doesn\'t match Password')
end

Then(/^user "(.*?)" should not be registered$/) do |user_email|
  # Check user in database
  desired_user = ((ENV['RAILS_VERSION'] == '3') ? User.where(:email => user_email).first : User.find_by(:email => user_email))
  desired_user.should == nil
  # Check there is no current user
  find("div#logged_in_user").should have_content("None")
end

Then(/^user "(.*?)" should be registered and signed in$/) do |user_email|
  # Check user in database
  desired_user = ((ENV['RAILS_VERSION'] == '3') ? User.where(:email => user_email).first : User.find_by(:email => user_email))
  desired_user.should_not == nil
  # Check this is the current user
  find("div#logged_in_user").should have_content("Logged in user: #{desired_user.email}")
end

Then(/^the filled Ajax content should be number "(.*?)"$/) do |iNbr|
  lCurrentNbr = 1
  lMatchingNbr = iNbr.to_i
  lJsonContentElement = nil
  loop do
    begin
      lJsonContentElement = find("div#json#{lCurrentNbr}_content")
    rescue Capybara::ElementNotFound
      lJsonContentElement = nil
    end
    if (lJsonContentElement != nil)
      if (lCurrentNbr == lMatchingNbr)
        # It should have content
        #page.should have_selector("div#json#{lCurrentNbr}_content", :text => "json#{lMatchingNbr}.1 ok#{lMatchingNbr}.1 json#{lMatchingNbr}.2 ok#{lMatchingNbr}.2")
        lJsonContentElement.should have_content("json#{lMatchingNbr}.1 ok#{lMatchingNbr}.1 json#{lMatchingNbr}.2 ok#{lMatchingNbr}.2")
      else
        # It should be empty
        lJsonContentElement.text.should be_empty
      end
    end
    break if (lJsonContentElement == nil)
    lCurrentNbr += 1
  end

end

Then /^the refresh counter "(.*?)" should be "(.*?)"$/ do |iCounterName, iCounterValue|
  find("div##{iCounterName}_RefreshCounter").should have_content("#{iCounterName} refresh counter: #{iCounterValue}")
end

Then /^the "(.*?)" parameter "(.*?)" should be "(.*?)"$/ do |iPageName, iParamName, iParamValue|
  find("div##{iPageName}_Param_#{iParamName}").should have_content("#{iParamName} = #{iParamValue}")
end

Then /^the location URL should be "(.*?)"$/ do |iURL|
  if @use_javascript
    page.evaluate_script('window.location.toString().split(window.location.protocol + \'//\' + window.location.host).join(\'\')').should == iURL
  else
    (current_url.sub(%r{.*?://},'')[%r{[/\?\#].*}] || '/').should == iURL
  end
end

Then /^element "(.*?)" should not be visible$/ do |iElementID|
  page.evaluate_script("isScrolledIntoView(jQuery('##{iElementID}'))").should == false
end

Then /^element "(.*?)" should be visible$/ do |iElementID|
  page.evaluate_script("isScrolledIntoView(jQuery('##{iElementID}'))").should == true
end

Then /^"(.*?)" should have popped$/ do |iMessage|
  page.evaluate_script('window.getNextAlertMessage();').should == iMessage
end

Then /^the flash message "(.*?)" should be "(.*?)"/ do |iFlashType, iMessage|
  find("div#Flash#{iFlashType}").should have_content(iMessage)
end

Then /^the "(.*?)" callback should have been called$/ do |iCallbackName|
  puts page.driver.console_messages.inspect
  page.evaluate_script('window.getNextCallback();').should == iCallbackName
end

Then /^the element "(.*?)" should be inside element "(.*?)"$/ do |iCSSElement, iCSSContainer|
  within(iCSSContainer) do
    page.should have_selector(iCSSElement)
  end
end
