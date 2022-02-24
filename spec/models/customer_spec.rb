require 'rails_helper'

RSpec.describe 'Customerモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { customer.valid? }

    let!(:other_customer) { create(:customer) } # let!は事前評価。各コード実行前に評価、実行される。
    let(:customer) { build(:customer) } # letは遅延評価。定義時に処理は実行されず、呼び出されたタイミングで始めて処理を実行。

    context 'last_nameカラム' do
      it '空欄でないこと' do
        customer.last_name = ''
        expect(subject).to eq false
      end
    end

    context 'first_nameカラム' do
      it '空欄でないこと' do
        customer.first_name = ''
        expect(subject).to eq false
      end
    end

    context 'last_name_kanaカラム' do
      it '空欄でないこと' do
        customer.last_name_kana = ''
        expect(subject).to eq false
      end

      it 'カタカナであれば登録できる' do
        customer.last_name_kana = 'カナ'
        expect(subject).to eq true
      end

      it 'カタカナ以外は登録できないこと' do
        customer.last_name_kana = 'あああ'
        expect(subject).to eq false
      end
    end

    context 'first_name_kanaカラム' do
      it '空欄でないこと' do
        customer.first_name_kana = ''
        expect(subject).to eq false
      end

      it 'カタカナであれば登録できる' do
        customer.first_name_kana = 'カナ'
        expect(subject).to eq true
      end

      it 'カタカナ以外は登録できないこと' do
        customer.first_name_kana = 'あああ'
        expect(subject).to eq false
      end
    end

    context 'addressカラム' do
      it '空欄でないこと' do
        customer.address = ''
        expect(subject).to eq false
      end
    end

    context 'telカラム' do
      it '空欄でないこと' do
        customer.tel = ''
        expect(subject).to eq false
      end
    end

    context 'emailカラム' do
      it '空欄でないこと' do
        customer.email = ''
        expect(subject).to eq false
      end

      it '一意性があること' do
        customer.email = other_customer.email
        expect(subject).to eq false
      end
    end
  end
end
