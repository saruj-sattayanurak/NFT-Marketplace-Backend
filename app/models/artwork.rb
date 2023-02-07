class Artwork < ApplicationRecord
    enum status: {unavailable: 0, available: 1}

    validates :name, presence: true
    validates :description, presence: true

    include AASM
    aasm column: :status, enum: true do
      state :available, initial: true
      state :unavailable
    end
end
