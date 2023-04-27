class AddAdminToArticles < ActiveRecord::Migration[7.0]
  def change
    add_column :articles, :edited_by_admin, :boolean, default: false, null: false
    add_column :articles, :edited_by, :integer
    add_column :articles, :edited_at, :datetime

    add_column :events, :edited_by_admin, :boolean, default: false, null: false
    add_column :events, :edited_by, :integer
    add_column :events, :edited_at, :datetime
  end
end
