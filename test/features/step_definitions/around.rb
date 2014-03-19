# Don't execute scenarios that do not apply to Rails 3
Around('@no_rails3') do |scenario, block|
  block.call unless (ENV['RAILS_VERSION'] == '3')
end

# Parse tags
Before do |scenario|
  tags = scenario.instance_variable_get(:@tags).to_sexp.map { |tag_info| tag_info[1] }
  @use_javascript = tags.include?('@javascript')
  @trap_alerts = tags.include?('@trap_alerts')
  @set_callbacks = tags.include?('@set_callbacks')
end

After do
  # Reset the config if needed
  visit '/configure?main_container=Content&flash_container_notice=FlashNotice&flash_container_alert=FlashAlert&flash_container_error=FlashError' if @config_modified
  # Reset Warden environment
  Warden.test_reset!
end

# Check there are no remaining callbacks to be acknowledged
After('@set_callbacks') do
  # $stdout.puts '=============== Console messages'
  # $stdout.puts page.driver.console_messages.join("\n")
  # $stdout.puts '==============='
  page.execute_script('window.cancelNextBeforeSend = false;')
  page.evaluate_script('window.getNextCallback();').should be_nil
end

# Check that all alerts have been trapped
After('@trap_alerts') do
  page.execute_script('window.alert = window.originalAlert;')
  page.evaluate_script('window.getNextAlertMessage();').should be_nil
end
