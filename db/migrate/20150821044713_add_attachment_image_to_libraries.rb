class AddAttachmentImageToLibraries < ActiveRecord::Migration
  def self.up
    change_table :libraries do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :libraries, :image
  end
end
