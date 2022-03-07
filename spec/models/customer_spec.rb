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
      it 'カタカナであれば登録できること' do
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
      it 'カタカナであれば登録できること' do
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
      it '数字以外は登録できないこと' do
        customer.tel = Faker::Lorem.characters(number: 10)
        expect(subject).to eq false
      end
      it '数字は登録できること' do
        customer.tel = '012333333'
        expect(subject).to eq true
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

  describe 'アソシエーションのテスト' do
    context 'PostMessageモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:post_messages).macro).to eq :has_many
      end
    end

    context 'Favoritesモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:favorites).macro).to eq :has_many
      end
    end

    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'Historyモデルとの関係' do
      it '1:Nとなっている' do
        expect(Customer.reflect_on_association(:histories).macro).to eq :has_many
      end
    end
  end

  describe 'メソッドのテスト' do
    context '姓、名が登録されている場合' do
      let(:customer) { build(:customer) }

      it '性名が取得できること' do
        customer.last_name = '河野'
        customer.first_name = '太郎'
        expect(customer.full_name).to eq '河野 太郎'
      end

       it '性名(カナ)が取得できること' do
        customer.last_name_kana = 'カワノ'
        customer.first_name_kana = 'タロウ'
        expect(customer.full_name_kana).to eq 'カワノ タロウ'
      end
    end
  end
  
end
