class CreateActivityStreams < ActiveRecord::Migration[5.0]
  def change
    create_table :activity_streams do |t|
      t.string :author_id
      t.string :author
      t.string :blog_id
      t.string :blog_title
      t.string :category_id
      t.string :category_name
      t.string :action

      t.timestamps
    end
  end
end
