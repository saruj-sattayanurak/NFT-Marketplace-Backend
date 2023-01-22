FactoryBot.define do
    factory :artwork, class: "Artwork" do
      sequence(:name) { |n| "art#{n}" }
      sequence(:description) { |n| "desp#{n}" }
      sequence(:image_url) { |n| "link#{n}" }
      sequence(:price) { |n| n }
    end
  end