class AddVisibilityCheckToImages < ActiveRecord::Migration[6.1]
  def change
    add_column :images, :is_public, :boolean, :default => false
  end
end
