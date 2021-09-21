class RenamePostsToEvents < ActiveRecord::Migration[6.1]
  def change
    rename_table :posts, :events
    rename_column :images, :post_id, :event_id
    add_column :events, :user_id, :integer
  end
end
