class DropPhotosTable < ActiveRecord::Migration[5.0]
  def change
  	drop_table :admin_photos
  end
  	
end
