class ChangePostIdToPinIdInComments < ActiveRecord::Migration
  def change
    rename_column :comments, :post_id, :pin_id
  end
end
