Feature: Merge Articles
  As an admin
  In order to not have duplicate articles
  I want to merge articles on same topic

  Scenario: A non-admin cannot merge articles
    Given the blog is set up with a none admin user
    And I am logged into as a none admin
    Given there is an article with title "Frog" and another with "Dog"
    #And I am on the edit page of the article "Frog"
    #When I try to merge it with article "Dog"
    #Then I should get an error message
    #
     Scenario: The merged article should contain the text of both previous articles.
       Given the blog is set up
       And I am logged into the admin panel
       When I merge the articles with text "Cooking is fun!" and "Programming is the best!"
       Then the text of the new article "Article1" should contain both "Cooking is fun!" and "Programming is the best!"
     Scenario: The merged article should have one author
       Given the blog is set up
       And I am logged into the admin panel
       When I merge the articles with authors "Jonathan Cat" and "Cow Moo"
       Then the author of the new article titled "art1" should be either "Jonathan Cat" or "Cow Moo"
    
     Scenario: Comments of the two articles should carry over and point to the new, merged article
       Given the blog is set up
       And I am logged into the admin panel
       When I merge one article with comment "Hi" and another with "Bye"
       Then the comment of the new "art1" should contain both "Hi" and "Bye"
    
     Scenario: The title of the new article should be the title from either one of the merged articles
       Given the blog is set up
       And I am logged into the admin panel
       When I merge the articles with title "Cooking" and "Programming"
       Then the title of the new article should be "Cooking" or "Programming"
