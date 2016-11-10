class Admin::Article < ApplicationRecord
  attr_accessor :coverphoto
  has_many :coverphoto
  accepts_nested_attributes_for :coverphoto
end
