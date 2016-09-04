class ChangeColumnTypeToInteger < ActiveRecord::Migration[5.0]
  def change
    change_column :activity_streams, :author_id, :integer
    change_column :activity_streams, :blog_id, :integer
    change_column :activity_streams, :category_id, :integer
  end
end
