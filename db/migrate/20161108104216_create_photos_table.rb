class CreatePhotosTable < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_photos do |t|
      t.string :title
      t.string :image
      t.integer :bytes
      t.references :imageable, :polymorphic => true

      t.timestamps
  end
  end
end
