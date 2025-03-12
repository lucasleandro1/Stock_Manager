# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Category, type: :model do
  describe '#validations' do
    context 'when present' do
      it { is_expected.to validate_presence_of(:name) }
    end
  end
end
