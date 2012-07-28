When /^I visit "(.*?)" page$/ do |path|
  visit path
end

When /^I click "(.*?)" link$/ do |link|
  click_link(link)
end

And /^I fill in "(.*?)" field with "(.*?)"$/ do |field, value|
  fill_in(field, with: value)
end

When /^I click "(.*?)" button$/ do |button|
  click_button(button)
end

Then /^I should see succeed signin messages$/ do
  page.body.should =~ /Logged in as/m
end

Then /^I should see error with email messages$/ do
  uri = URI.parse(current_url)
  uri.path.should.should eq('/accounts/signup')
  # TODO "email"でエラーが出ていることのテストを書かなければならない
  # TODO 更には、空だというメッセージも出さないといけない
  page.body.should =~ /Opps, unable to signup/m
end
