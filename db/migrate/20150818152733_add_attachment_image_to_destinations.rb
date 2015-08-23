class AddAttachmentImageToDestinations < ActiveRecord::Migration
  def self.up
    change_table :destinations do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :destinations, :image
  end
end
