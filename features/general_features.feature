Feature: Editing an organization
    As a kanban owner
    In order to control my tasks
    I want to be able to edit information

    Background:
        Given I have an account
        And I have a kanban and a task
        And I am logged into my account

    Scenario: Successful edit
        When I click link for kanban
        And I click link for organization
        Then I see a main page for this organization
        When I successfully edit the organization
        Then I see an updated page for this organization

