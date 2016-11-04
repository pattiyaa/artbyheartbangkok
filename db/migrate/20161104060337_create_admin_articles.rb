class CreateAdminArticles < ActiveRecord::Migration[5.0]
  def change
    create_table :admin_articles do |t|
      t.string :title
      t.string :subtitle
      t.text :body
      t.datetime :createdate
      t.datetime :modifydate
      t.string :coverphoto_url
      t.string :category
      t.boolean :isHighlight
      t.boolean :isToplist

      t.timestamps

      
    end
  end
end
