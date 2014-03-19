Then(/^the page should be empty$/) do
  page.body.strip.should be_empty
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

Then(/^the filled Ajax content should be number "(.*?)"$/) do |json_index|
  current_index = 1
  json_index = json_index.to_i
  json_content_element = nil
  loop do
    begin
      json_content_element = find("div#json#{current_index}_content")
    rescue Capybara::ElementNotFound
      json_content_element = nil
    end
    if (json_content_element != nil)
      if (current_index == json_index)
        # It should have content
        #page.should have_selector("div#json#{current_index}_content", :text => "json#{json_index}.1 ok#{json_index}.1 json#{json_index}.2 ok#{json_index}.2")
        json_content_element.should have_content("json#{json_index}.1 ok#{json_index}.1 json#{json_index}.2 ok#{json_index}.2")
      else
        # It should be empty
        json_content_element.text.should be_empty
      end
    end
    break if (json_content_element == nil)
    current_index += 1
  end

end

Then /^the refresh counter "(.*?)" should be "(.*?)"$/ do |counter_name, counter_value|
  find("div##{counter_name}_RefreshCounter").should have_content("#{counter_name} refresh counter: #{counter_value}")
end

Then /^the "(.*?)" parameter "(.*?)" should be "(.*?)"$/ do |page_name, param_name, param_value|
  find("div##{page_name}_Param_#{param_name}").should have_content("#{param_name} = #{param_value}")
end

Then /^the location URL should be "(.*?)"$/ do |url|
  if @use_javascript
    page.evaluate_script('window.location.toString().split(window.location.protocol + \'//\' + window.location.host).join(\'\')').should == url
  else
    (current_url.sub(%r{.*?://},'')[%r{[/\?\#].*}] || '/').should == url
  end
end

Then /^element "(.*?)" should not be visible$/ do |element_id|
  page.evaluate_script("isScrolledIntoView(jQuery('##{element_id}'))").should == false
end

Then /^element "(.*?)" should be visible$/ do |element_id|
  page.evaluate_script("isScrolledIntoView(jQuery('##{element_id}'))").should == true
end

Then /^"(.*?)" should have popped$/ do |message|
  page.evaluate_script('window.getNextAlertMessage();').should == message
end

Then /^the flash message "(.*?)" should be "(.*?)"/ do |flash_type, message|
  find("div#Flash#{flash_type}").should have_content(message)
end

Then /^the "(.*?)" callback should have been called$/ do |callback_name|
  page.evaluate_script('window.getNextCallback();').should == callback_name
end

Then /^the element "(.*?)" should be inside element "(.*?)"$/ do |elem_css_selector, container_css_selector|
  within(container_css_selector) do
    page.should have_selector(elem_css_selector)
  end
end
