Given(/^I've get business types$/) do
  @business_types = get_business_types
end

Then(/^I should see all business categories$/) do
  @business_types.each do |business_type|
    puts "#{business_type['name']}:"
    get_business_categories(business_type["id"]).each do |business_category|
      puts "- #{business_category['name']}"
    end
    puts ""
  end
end
