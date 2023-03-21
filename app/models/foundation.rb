class Foundation < ApplicationRecord
  devise :database_authenticatable
  has_many :artworks
end
