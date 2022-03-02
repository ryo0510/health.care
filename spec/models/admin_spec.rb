require 'rails_helper'

RSpec.describe 'Adminモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { admin.valid? }

    let!(:other_admin) { create(:admin) }
    let(:admin) { build(:admin) }

    context 'emailカラム' do
      it '空欄でないこと' do
        admin.email = ''
        expect(subject).to eq false
      end
      it '一意性があること' do
        admin.email = other_admin.email
        expect(subject).to eq false
      end
    end
  end
end