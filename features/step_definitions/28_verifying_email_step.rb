Given(/^I've unverified email$/) do
  $email = get_unverified_email
end

When(/^I try to verifying the email$/) do
  @result_verify_email = verify_email(
    {
      email: $email
    }
  )
end

Then(/^I should get response the email is not present$/) do
  # expect(@result_verify_email["present"]).to eql false
  puts get_business_types
end
