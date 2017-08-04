Given(/^I've unverified random email$/) do
  $email = "#{Time.now.to_i}-#{get_unverified_random_email}" 
end

When(/^I try to registering the email$/) do
  business_type = get_business_types[0]
  business_type_id = business_type["id"]
  business_category = get_business_categories(business_type_id)[0]
  name = Faker::Company.name
  address = Faker::Address.street_address
  city = Faker::Address.city
  province = Faker::Address.state
  postal_code = Faker::Address.postcode
  password = "123456"
  full_name = Faker::Name.name.split(" ")
  first_name = full_name[0]
  last_name = full_name[1]
  phone = Faker::PhoneNumber.phone_number
  agent = "browser"
  email = $email

  result = registering_user(
    {
      params: {
        business: {
          business_type_id: business_type_id,
          business_category_id: business_category["id"],
          name: name,
          address: address,
          city: city,
          province: province,
          postal_code: postal_code
        },
        user: {
          email: email,
          password: password,
          password_confirmation: password,
          last_name: last_name,
          first_name: first_name,
          phone: phone
        },
        agent: agent
      }
    }
  )

  expect(result["id"]).to be_present
end

When(/^I try to login using the email$/) do
  visit '/account/#/login'
  fill_in "user[email]", with: $email 
  fill_in "user[password]", with: "123456"
  click_button "Sign In"
end

Then(/^I should failed to login because i've not yet verified my account$/) do
  expect(page).to have_content("You need to verify your account before continue. Please check your email.")
end
