class AddAttachmentImageToFavorites < ActiveRecord::Migration
  def self.up
    change_table :favorites do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :favorites, :image
  end
end
