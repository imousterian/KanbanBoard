Given(/^I have an account$/) do
  @user = User.create(username: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

Given(/^I have a kanban and a task$/) do
    @org = Organization.create!(name: "Org1")
    @kanban = @user.kanbans.create!(name: "Kanban1")
    @org.kanbans << @kanban
end

Given(/^I am logged into my account$/) do
  visit signin_path
  fill_in "Email",    :with => @user.email
  fill_in "Password", :with => @user.password
  click_button "Sign in"

  expect(page).to have_content('welcome, ' + @user.username)

end


When(/^I click link for kanban$/) do
  click_link(@kanban.name)
  expect(page).to have_content(@kanban.name)
end

And(/^I click link for organization$/) do
  click_link(@org.name)
end

Then(/^I see a main page for this organization$/) do
  expect(page).to have_content(@org.name)
end

When(/^I successfully edit the organization$/) do
    click_link "Edit"
    expect(page).to have_content("Editing " + @org.name)

    fill_in "organization_name", :with => "Edited Name"
    fill_in "organization_content", :with => "Edited Content"
    click_button "Save"
end

Then(/^I see an updated page for this organization$/) do


    expect(page).to have_content("Edited Name")
    expect(page).to have_content("Edited Content")
end
