Given /^I am on the home page$/ do
  visit root_path
  # Set all necessary JS hooks
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
        window.callbacksCalled[window.callbacksCalled.length] = \'beforeSend\';
        return !window.cancelNextBeforeSend;
      };
      railsAjax.success = function(iXHR, iData) {
        window.callbacksCalled[window.callbacksCalled.length] = \'success\';
      };
      railsAjax.error = function(iXHR, iError) {
        window.callbacksCalled[window.callbacksCalled.length] = \'error\';
      };
      railsAjax.complete = function(iXHR) {
        window.callbacksCalled[window.callbacksCalled.length] = \'complete\';
      };
      window.getNextCallback = function() {
        var lResult = window.callbacksCalled[0];
        window.callbacksCalled.splice(0, 1);
        return lResult;
      };
    ')
  end
end

Given /^I setup flash container "(.*?)" to "(.*?)"$/ do |flash_type, container_id|
  visit "/configure?flash_container_#{flash_type}=#{container_id}"
  @config_modified = true
end

Given /^I setup the main container to "(.*?)"$/ do |container_id|
  visit "/configure?main_container=#{container_id}"
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

Given(/^user "(.*?)" is registered with password "(.*?)"$/) do |user_email, user_password|
  @registered_user = FactoryGirl.create(:user, :email => user_email, :password => user_password, :password_confirmation => user_password)
end

Given(/^user is signed in$/) do
  login_as(@registered_user, :scope => :user)
end
