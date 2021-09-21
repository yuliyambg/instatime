class RemoveAttachmentImageFromEvent < ActiveRecord::Migration[6.1]
  def change
    remove_attachment :events, :image
  end
end
