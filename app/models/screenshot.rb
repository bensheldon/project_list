class Screenshot < ApplicationRecord
  has_one_attached :desktop_image
  has_one_attached :mobile_image
end
