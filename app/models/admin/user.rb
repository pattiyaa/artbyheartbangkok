class Admin::User < ApplicationRecord
  attr_accessor :photo
  has_one :photo
  accepts_nested_attributes_for :photo
end
