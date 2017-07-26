Given(/^I go to switching to html frame page$/) do
  filename = "file:///Users/yogamokapos/Google\ Drive/Selenium\ Training/28\ July\ 2017/5.\ Switching\ to\ a\ HTML\ frame/index.html"
  Capybara.current_session.driver.visit filename
end

When(/^I switch to "([^"]*)"$/) do |frame_name|
  frame_names = {
    "Frame A" => "frame_a",
    "Frame B" => "frame_b",
    "Frame C" => "frame_c"
  }

  page.driver.browser.switch_to.frame frame_names[frame_name]
end

Then(/^I should see "([^"]*)" content$/) do |frame_name|
  expect(all("h3")[0].text).to eql frame_name
end
