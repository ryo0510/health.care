require 'rails_helper'

RSpec.describe 'PostMessageモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { post_message.valid? }

    let(:customer) { create(:customer) }
    let!(:post_message) { build(:post_message, customer_id: customer.id) }

    context 'nicknameカラム' do
      it '空欄でないこと' do
        post_message.nickname = ''
        expect(subject).to eq false
      end
      it '10文字以下であること: 10文字は〇' do
        post_message.nickname = Faker::Lorem.characters(number: 10)
        expect(subject).to eq true
      end
      it '10文字以下であること: 11文字は×' do
        post_message.nickname = Faker::Lorem.characters(number: 11)
        expect(subject).to eq false
      end
    end

    context 'messageカラム' do
      it '空欄でないこと' do
        post_message.message = ''
        is_expected.to eq false
      end
      it '140文字以下であること: 140文字は〇' do
        post_message.message = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it '140文字以下であること: 141文字は×' do
        post_message.message = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(PostMessage.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end
    
    context 'Favoriteモデルとの関係' do
      it '1:Nとなっている' do
        expect(PostMessage.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end
  end
end