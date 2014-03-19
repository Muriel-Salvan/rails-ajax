When(/^user signs out$/) do
  find_button('Sign out').click
end

When(/^I sign in user "(.*?)" with password "(.*?)"$/) do |user_email, user_password|
  fill_in('Email', :with => user_email)
  fill_in('Password', :with => user_password)
  click_on('Sign in')
end

When /^I click on "(.*?)" from "(.*?)"$/ do |link_name, context_name|
  click_link("Go to #{link_name} from #{context_name}")
end

When(/^I click the button "(.*?)" from "(.*?)"$/) do |link_name, context_name|
  find_button("Button to #{link_name} from #{context_name}").click
end

When /^I submit "([^"]*?)" using "([^"]*?)"$/ do |text_value, button_name|
  # Find the button first, before filling in the text field, as otherwise the driver could fill the previous text field if the Ajax call did not return the new page fast enough.
  button = find_button(button_name)
  all(:field, 'Text field').each do |element|
    element.set(text_value)
  end
  button.click
end

When /^I submit "([^"]*?)" in "([^"]*?)" using "([^"]*?)"$/ do |text_value, field_name, button_name|
  fill_in(field_name, :with => text_value)
  click_on(button_name)
end

When /^I go back "(.*?)" times in history$/ do |nbr_times|
  nbr_times.to_i.times do
    # TODO (Webkit): Remove this sleep when Capybara-webkit will handle history correctly. Test on Travis.
    sleep 5
    page.execute_script('window.history.back();')
  end
end

When /^I wait for "(.*?)"$/ do |div_id|
  page.should have_selector("div##{div_id}")
end

When /^I manually enter URL "(.*?)"$/ do |url|
  visit(url)
end

When(/^I make the Ajax call number "(.*?)"$/) do |json_index|
  click_link("json#{json_index}_link")
end

When(/^I make the Ajax form call number "(.*?)"$/) do |json_index|
  click_button("json#{json_index}_button")
end

When(/^I wait for "(.*?)" callbacks to be triggered$/) do |nbr_callbacks|
  # First make sure the variable is still accessible.
  # It can be absent if the page was refreshed.
  raise 'Unable to get callbacks back: the page has certainly been refreshed completely whereas it should not have.' if (page.evaluate_script('window.callbacksCalled.length;') == nil)
  nbr_callbacks = nbr_callbacks.to_i
  Timeout::timeout(nbr_callbacks*2) do
    while (page.evaluate_script('window.callbacksCalled.length;') < nbr_callbacks)
      sleep 1
    end
  end
end
