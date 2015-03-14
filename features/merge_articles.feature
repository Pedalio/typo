Feature: Merge Articles
  As an admin
  In order to not have duplicate articles
  I want to merge articles on same topic

  Scenario: A non-admin cannot merge articles
    Given I am not an admin
    And I am on the merge articles page
    When I try to merge the articles
    Then I should get an error message

  Scenario: The merged article should contain the text of both previous articles.
    Given I am an admin
    And I am on the merge articles page
    When I merge the articles with text "Cooking" and "Programming"
    Then the text of the new article should contain both "Cooking" and "Programming"

  Scenario: The merged article should have one author
    Given I am an admin
    And I am on the merge articles page
    When I merge the articles with autors "Jonathan Cat" and "Cow Moo"
    Then the author of the new article should be either "Cooking" or "Programming"

  Scenario: Comments of the two articles should carry over and point to the new, merged article
    Given I am an admin
    And I am on the merge articles page
    When I merge one article with comment "Hi" and another with "Bye"
    Then the comment of the new article should contain both "Cooking" and "Programming"

  Scenario: The title of the new article should be the title from either one of the merged articles
    Given I am an admin
    And I am on the merge articles page
    When I merge the articles with title "Cooking" and "Programming"
    Then the title of the new article should be "Cooking" or "Programming"

