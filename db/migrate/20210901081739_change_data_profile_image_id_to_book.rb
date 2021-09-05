class ChangeDataProfileImageIdToBook < ActiveRecord::Migration[5.2]
  def change
    change_column :books, :profile_image_id, :text
  end
end
