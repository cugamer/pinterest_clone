class AddPinImageToPins < ActiveRecord::Migration
  def change
    add_column :pins, :pin_image, :string
  end
end
