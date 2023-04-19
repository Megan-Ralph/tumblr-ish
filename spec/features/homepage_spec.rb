require 'rails_helper'
 
feature 'Homepage Visit' do

  scenario 'without a user' do
    visit(root_path) 
    expect(page).to have_content 'Hello'
  end
end
