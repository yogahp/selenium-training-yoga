When(/^I click "([^"]*)" link$/) do |string|
  click_link(string)
end

When(/^I try to go back to homepage$/) do
  page.driver.go_back
end

Then(/^I should see homepage$/) do
  expect(page.current_url).to eql "#{Capybara.app_host}/"
end

Then(/^I try to go forward to login page$/) do
  page.driver.go_forward
end

Then(/^I should see login page$/) do
  expect(page.current_url).to eql "#{Capybara.app_host}/account/#/login"
end
