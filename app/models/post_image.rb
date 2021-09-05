class PostImage < ApplicationRecord
  belongs_to :user, optional: true
end
