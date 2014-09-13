Given(/^I have an account$/) do
  @user = User.create(username: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
end

Given(/^I have a kanban and a task$/) do
    @task = Task.create!(name: "Org1")
    @kanban = @user.kanbans.create!(name: "Kanban1")
    @task.kanbans << @kanban
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

And(/^I click link for task$/) do
  click_link(@task.name)
end

Then(/^I see a main page for this task$/) do
  expect(page).to have_content(@task.name)
end

When(/^I successfully edit the task$/) do
    click_link "Edit"
    expect(page).to have_content("Editing " + @task.name)

    fill_in "task_name", :with => "Edited Name"
    fill_in "task_content", :with => "Edited Content"
    click_button "Save"
end

Then(/^I see an updated page for this task$/) do


    expect(page).to have_content("Edited Name")
    expect(page).to have_content("Edited Content")
end
