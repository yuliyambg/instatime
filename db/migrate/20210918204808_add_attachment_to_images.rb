class AddAttachmentToImages < ActiveRecord::Migration[6.1]

  def self.up
    change_table :images do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :images, :image
  end

end
