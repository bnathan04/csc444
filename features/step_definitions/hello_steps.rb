When(/^I go to the homepage$/) do
  visit root_path
end

Then(/^I should see the LNDR$/) do
  expect(page).to have_content("LNDR")
end