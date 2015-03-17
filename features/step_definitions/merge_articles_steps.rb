Given /^the blog is set up with a none admin user$/ do
  Blog.default.update_attributes!({:blog_name => 'Teh Blag',
                                   :base_url => 'http://localhost:3000'});
  Blog.default.save!
  User.create!({:login => 'publisher',
                :password => 'aaaaaaaa',
                :email => 'joe@snow.com',
                :profile_id => 3,
                :name => 'publisher',
                :state => 'active'})
end

And /^I am logged into as a none admin$/ do
  visit '/accounts/login'
  fill_in 'user_login', :with => 'publisher'
  fill_in 'user_password', :with => 'aaaaaaaa'
  click_button 'Login'
  if page.respond_to? :should
    page.should have_content('Login successful')
  else
    assert page.has_content?('Login successful')
  end
end


Given /^there is an article with title "(.*)" and another with "(.*)"$/ do |title1, title2|
    usr1 = User.create!({:login => 'auth1',
                :password => '11111',
                :email => 'usr@1.com',
                :profile_id => 11,
                :name => 'auth1',
                :state => 'active'})
    usr2 = User.create!({:login => 'auth2',
                :password => '22222',
                :email => 'usr@2.com',
                :profile_id => 12,
                :name => 'auth2',
                :state => 'active'})
    art1 = Article.create!(title: title1, user_id: usr1.id, body: "text1")
    art2 = Article.create!(title: title2, user_id: usr2.id, body: "text2")
end

When /^I try to merge it with article "(.*)"$/ do |title|
    fill_in "article_id", with: "#{Article.where(title: title).first.id}"
    click_button "Merge"
end
#Then I should get an error message
#
When /^I merge the articles with text "(.*)" and "(.*)"$/ do |text1, text2|
    art1 = Article.create!(title: "Article1", body: text1) 
    art2 = Article.create!(title: "Article2", body: text2) 
    steps %Q{ And I am on the edit page of the article "Article1" }
    steps %Q{ When I try to merge it with article "Article2" }
end

Then /^the text of the new article "(.*?)" should contain both "(.*?)" and "(.*?)"$/ do |new, text1, text2|
    new_art = Article.where(title: new).first
    assert(new_art != nil)
    new_art.body.include? text1 and new_art.body.include? text2
    new_art.body.include?(text1).should == true
    new_art.body.include?(text2).should == true
end

When /^I merge the articles with authors "(.*)" and "(.*)"$/ do |auth1, auth2|
    usr1 = User.create!({:login => auth1,
                :password => '11111',
                :email => 'usr@1.com',
                :profile_id => 11,
                :name => auth1,
                :state => 'active'})
    usr2 = User.create!({:login => 'auth2',
                :password => '22222',
                :email => 'usr@2.com',
                :profile_id => 12,
                :name => auth2,
                :state => 'active'})
    art1 = Article.create!(title: "art1", user_id: usr1.id, body: "text1")
    art2 = Article.create!(title: "art2", user_id: usr2.id, body: "text2")
    steps %Q{ And I am on the edit page of the article "art1" }
    steps %Q{ When I try to merge it with article "art2" }
end

Then /^the author of the new article titled "(.*)" should be either "(.*)" or "(.*)"$/ do |title, auth1, auth2|
    art = Article.where(title: title).first
    assert(art != nil)
    assert(art.user.name == auth1 || art.user.name == auth2)
end

When /^I merge one article with comment "(.*)" and another with "(.*)"$/ do |cm1, cm2|
    usr1 = User.create!({:login => 'auth1',
                :password => '11111',
                :email => 'usr@1.com',
                :profile_id => 11,
                :name => 'auth1',
                :state => 'active'})
    usr2 = User.create!({:login => 'auth2',
                :password => '22222',
                :email => 'usr@2.com',
                :profile_id => 12,
                :name => 'auth2',
                :state => 'active'})
    art1 = Article.create!(title: "art1", user_id: usr1.id, body: "text1")
    art2 = Article.create!(title: "art2", user_id: usr2.id, body: "text2")
    comment1 = Comment.create!(body: cm1, article_id: art1.id, author: usr1)
    comment2 = Comment.create!(body: cm2, article_id: art2.id, author: usr2)
    steps %Q{ And I am on the edit page of the article "art1" }
    steps %Q{ When I try to merge it with article "art2" }
end

Then /^the comment of the new "(.*)" should contain both "(.*)" and "(.*)"$/ do |title, cm1, cm2|
    new_art = Article.where(title: title).first
    comments = Comment.where(article_id: new_art.id)
    comments.each do |comment|
        assert(comment.body == cm1 || comment.body == cm2)
    end
end

When /^I merge the articles with title "(.*)" and "(.*)"$/ do |title1, title2|
    usr1 = User.create!({:login => 'auth1',
                :password => '11111',
                :email => 'usr@1.com',
                :profile_id => 11,
                :name => 'auth1',
                :state => 'active'})
    usr2 = User.create!({:login => 'auth2',
                :password => '22222',
                :email => 'usr@2.com',
                :profile_id => 12,
                :name => 'auth2',
                :state => 'active'})
    art1 = Article.create!(title: title1, user_id: usr1.id, body: "text1")
    art2 = Article.create!(title: title2, user_id: usr2.id, body: "text2")
    steps %Q{ And I am on the edit page of the article "#{title1}" }
    steps %Q{ When I try to merge it with article "#{title2}" }
    
end

Then /^the title of the new article should be "(.*)" or "(.*)"$/ do |title1, title2|
    art1 = Article.where(title: title1).first
    art2 = Article.where(title: title2).first
    art1.title.should == title1
    art2.should == nil
end
