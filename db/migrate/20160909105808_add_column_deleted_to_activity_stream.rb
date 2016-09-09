class AddColumnDeletedToActivityStream < ActiveRecord::Migration[5.0]
  def change
    add_column :activity_streams, :deleted, :integer, default: 0, limit: 1
  end
end
