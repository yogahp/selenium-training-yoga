World(ShowMeTheCookies)

When(/^I fill in "([^"]*)" field with "([^"]*)"$/) do |field, value|
  fill_in field, with: value
end

When(/^I click "([^"]*)" button$/) do |string|
  click_button string
end

Then(/^I should have cookie named "([^"]*)"$/) do |cookie_name|
  sleep 5
  cookie = get_me_the_cookie(cookie_name)
  expect(cookie).to be_present
end
