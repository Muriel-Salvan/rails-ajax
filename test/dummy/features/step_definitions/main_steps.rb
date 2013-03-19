#--
# Copyright (c) 2012 Muriel Salvan (Muriel@X-Aeon.com)
# Licensed under the terms specified in LICENSE file. No warranty is provided.
#++

Before do |iScenario|
  lTags = iScenario.instance_variable_get(:@tags).to_sexp.map { |iTagInfo| iTagInfo[1] }
  @use_javascript = lTags.include?('@javascript')
  @trap_alerts = lTags.include?('@trap_alerts')
  @set_callbacks = lTags.include?('@set_callbacks')
end

After do |iScenario|
  if @trap_alerts
    # Check that all alerts have been trapped
    page.execute_script('window.alert = window.originalAlert;')
    page.evaluate_script('window.getNextAlertMessage();').should be_nil
  end
  if @set_callbacks
    page.execute_script('window.cancelNextBeforeSend = false;')
    page.evaluate_script('window.getNextCallback();').should be_nil
  end
  if @config_modified
    # Reset the config
    visit '/configure?main_container=Content&flash_container_notice=FlashNotice&flash_container_alert=FlashAlert&flash_container_error=FlashError'
  end
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
    page.execute_script('window.history.back();')
  end
end

When /^I wait for "(.*?)"$/ do |iPageName|
  page.should have_selector("div##{iPageName}")
end

When /^I manually enter URL "(.*?)"$/ do |iURL|
  visit(iURL)
end

Then /^the refresh counter "(.*?)" should be "(.*?)"$/ do |iCounterName, iCounterValue|
  Capybara.default_wait_time = 60
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
  page.evaluate_script('window.getNextCallback();').should == iCallbackName
end

Then /^the element "(.*?)" should be inside element "(.*?)"$/ do |iCSSElement, iCSSContainer|
  within(iCSSContainer) do
    page.should have_selector(iCSSElement)
  end
end
