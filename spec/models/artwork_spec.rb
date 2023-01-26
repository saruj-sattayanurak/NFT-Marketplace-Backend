require "rails_helper"

RSpec.describe Artwork, type: :model do
  describe "validates" do

    describe "validates for presence" do
      context "name" do
        it { should validate_presence_of(:name) }
      end

      context "description" do
        it { should validate_presence_of(:description) }
      end

      context "image_url" do
        it { should validate_presence_of(:image_url) }
      end

      context "price" do
        it { should validate_presence_of(:price) }
      end
    end
  end

  describe "status" do

    subject { artwork.status }
    let(:artwork) { build :artwork }

    context "initial status" do
      it "available" do
        expect(subject).to eq("available")
      end
    end

  end
end
