class AddNotNullContraintsToTables < ActiveRecord::Migration[7.0]
  def change
    change_column_null :articles, :title, false
    change_column_null :articles, :body, false
    change_column_null :articles, :user_id, false

    change_column_null :events, :title, false
    change_column_null :events, :body, false
    change_column_null :events, :start_date, false
    change_column_null :events, :end_date, false
    change_column_null :events, :user_id, false

    change_column_null :comments, :body, false
  end
end
