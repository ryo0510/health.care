require 'rails_helper'

RSpec.describe 'Favoriteモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { favorite.valid? }

    let(:customer) { create(:customer) }
    let(:post_message) { create(:post_message, customer_id: customer.id) }
    let!(:favorite) { build(:favorite, customer_id: customer.id, post_message_id: post_message.id) }

    context 'customer_idカラム' do
      it '空欄でないこと' do
        favorite.customer_id = ''
        expect(subject).to eq false
      end
    end

    context 'post_message_idカラム' do
      it '空欄でないこと' do
        favorite.post_message_id = ''
        expect(subject).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end

    context 'PostMessageモデルとの関係' do
      it 'N:1となっている' do
        expect(Favorite.reflect_on_association(:post_message).macro).to eq :belongs_to
      end
    end
  end
end