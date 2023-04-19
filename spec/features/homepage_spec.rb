require 'rails_helper'
 
feature 'Visit Homepage' do

  scenario 'while not logged in' do
    visit(root_path) 
    expect(page).to have_content 'Log in'
  end

  scenario 'while logged in' do
    @user = create(:user)
    @article = create(:article)
    login_as(@user)

    visit(root_path)
    expect(page).to have_content 'Home'
    expect(page).to have_content 'Worlds best MMO!'
  end
end
