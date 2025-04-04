# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product, type: :model do
  describe "#validations" do
    context "when present" do
      it { is_expected.to validate_presence_of(:name) }
      it { is_expected.to validate_presence_of(:price) }
      it { is_expected.to validate_presence_of(:category_id) }
    end
  end

  describe "#associations" do
    context "when present" do
      it { is_expected.to have_many(:stock_movements).dependent(:destroy) }
      it { is_expected.to belong_to(:user) }
      it { is_expected.to belong_to(:category) }
    end
  end

  describe "#lucro_total" do
    let(:user) { create(:user) }
    let(:category) { create(:category, user: user) }
    let(:product) { create(:product, category: category, user: user) }

    before do
      create(:stock_movement, product: product, movement_type: :entrada, price: 5.0, quantity: 2)
      create(:stock_movement, product: product, movement_type: :saida, price: 15.0, quantity: 3)
    end

    it "calculates total profit correctly" do
      expect(product.lucro_total).to eq(45 - 10)
    end
    asdfsdfsa
  end
end
