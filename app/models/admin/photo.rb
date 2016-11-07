class Admin::Photo < ApplicationRecord
  attr_accessor :title, :bytes, :image, :image_cache
  #attr_accessible :title, :bytes, :image, :image_cache
  mount_uploader :image, ImageUploader
  
  validates_presence_of :title, :image
 

  #belongs_to :imageable, :polymorphic => true
end