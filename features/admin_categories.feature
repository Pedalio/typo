Feature: Display admin Categories
  As an admin
  In order to create new categories
  I want to be directed to Categories page correctly

    Scenario: Display admin Categories page correctly
        Given the blog is set up
        And I am logged into the admin panel
        When I am on the admin page
        And I follow "Categories"
        Then I should see "Categories"
