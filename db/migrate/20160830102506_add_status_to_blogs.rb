class AddStatusToBlogs < ActiveRecord::Migration[5.0]
  def change
    add_column :blogs, :status, :string
  end
end
