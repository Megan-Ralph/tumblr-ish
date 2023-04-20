require 'rails_helper'
 
feature 'Admin Users' do
  scenario "An admin user can edit any post" do
    user = create(:user)
    admin_user = create(:user, admin: true)
    article = create(:article, user_id: user.id)

    login_as(admin_user)

    visit article_path(article)
    expect(page).to have_content(article.title)
    expect(page).to have_content "Edit Article"
  end

  scenario "A normal user can edit their own post" do
    user = create(:user)
    article = create(:article, user_id: user.id)

    login_as(user)

    visit article_path(article)
    expect(page).to have_content(article.title)
    expect(page).to have_content "Edit Article"
  end

  scenario "A normal user cannot edit someone elses post" do
    user_one = create(:user)
    user_two = create(:user)
    article = create(:article, user_id: user_one.id)

    login_as(user_two)

    visit article_path(article)
    expect(page).to have_content(article.title)
    expect(page).to_not have_content "Edit Article"
  end
end
