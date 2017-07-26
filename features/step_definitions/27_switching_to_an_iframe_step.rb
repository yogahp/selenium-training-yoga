Given(/^I go to switching an iframe page$/) do
  filename = "file:///Users/yogamokapos/Google\ Drive/Selenium\ Training/28\ July\ 2017/6.\ Switching\ to\ an\ iframe/index.html"
  Capybara.current_session.driver.visit filename
end

When(/^I switch to iframe "([^"]*)"$/) do |iframe_name|
  iframe_names = {
    "Muslim Pro" => "muslimpro",
    "Moka Blog" => "moka_blog"
  }

  page.driver.browser.switch_to.frame iframe_names[iframe_name]
end

Then(/^I should see iframe "([^"]*)"$/) do |iframe_content|
  sleep 1
  expect(page).to have_content(iframe_content)
end
