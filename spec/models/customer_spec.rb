require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }

    let!(:other_customer) { create(:customer) } #letは遅延評価。定義時に処理は実行されず、呼び出されたタイミングで始めて処理を実行。
    let(:customer) { build(:customer) } #letは遅延評価。定義時に処理は実行されず、呼び出されたタイミングで始めて処理を実行。

    context 'last_nameカラム' do
      it '空欄でないこと' do
        customer.last_name = ''
        is_expected.to eq false
      end
    end

    context 'first_nameカラム' do
      it '空欄でないこと' do
        customer.first_name = ''
        is_expected.to eq false
      end
    end

    context 'last_name_kanaカラム' do
      it '空欄でないこと' do
        customer.last_name_kana = ''
        is_expected.to eq false
      end
      it 'カタカナ以外は登録できないこと' do
        customer.last_name_kana = 'あああ'
        is_expected.to eq false
      end
    end

    context 'first_name_kanaカラム' do
      it '空欄でないこと' do
        customer.first_name_kana = ''
        is_expected.to eq false
      end
      # it 'カタカナであれば登録できる' do
      #   customer.first_name_kana = 'person.first.katakana'
      #   is_expected.to eq true
      # end
      it 'カタカナ以外は登録できないこと' do
        customer.first_name_kana = 'あああ'
        is_expected.to eq false
      end
    end

    context 'addressカラム' do
      it '空欄でないこと' do
        customer.address = ''
        is_expected.to eq false
      end
    end

    context 'telカラム' do
      it '空欄でないこと' do
        customer.tel = ''
        is_expected.to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        customer.email = ''
        is_expected.to eq false
      end
      it '一意性があること' do
        customer.email = other_customer.email
        is_expected.to eq false
      end
    end

  end
end
