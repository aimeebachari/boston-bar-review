class Avatar < ApplicationRecord::BarsController
  mount_uploader :avatar_image, AvatarImageUploader
end
