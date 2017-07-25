Given(/^I go to home page$/) do
  visit "/"
end

When(/^I try to maximizing browser window$/) do
  @before_window_size = page.current_window.size
  page.driver.browser.manage.window.maximize
  @after_window_size = page.current_window.size
end

Then(/^I should see my browser maximized$/) do
  expect(@before_window_size).not_to eql @after_window_size
  sleep 5
end
