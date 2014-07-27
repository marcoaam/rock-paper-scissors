When(/^I click "(.*?)"$/) do |arg1|
  click_link arg1
end

When(/^I enter my name$/) do
  fill_in "name", with: "Stephen"
end

Then(/^I should be ready to play$/) do
  expect(page).to have_content("please pick an option")
end

Given(/^I've registered to play$/) do
  visit '/'
  click_button "Single Player"
  click_button "Play!"
end

Given(/^I've registered to play with two players$/) do
  visit '/'
  click_button "Two Players"
  fill_in "name", with: "Marco"
  click_button "Play!"
end

Then(/^Another player named Alex registers for playing$/) do
  visit '/'
  click_button "Two Players"
  fill_in "name", with: "Alex"
  click_button "Play!"
end

Then(/^The other player chooses Paper$/) do
  click_button "Paper"
end

When(/^I choose Paper$/) do
  click_button('Paper')
end