RSpec.describe 'Categoryモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { category.valid? }

    let!(:other_category) { create(:category) }
    let(:category) { build(:category) }

    context 'nameカラム' do
      it '空欄でないこと' do
        category.name = ''
        expect(subject).to eq false
      end
      it '一意性があること' do
        category.name = other_category.name
        expect(subject).to eq false
      end
      it '7文字以下であること: 7文字は〇' do
        category.name = Faker::Lorem.characters(number: 7)
        expect(subject).to eq true
      end
      it '7文字以下であること: 8文字は×' do
        category.name = Faker::Lorem.characters(number: 8)
        expect(subject).to eq false
      end
    end
  end
  
   describe 'アソシエーションのテスト' do
    context 'Courseモデルとの関係' do
      it '1:Nとなっている' do
        expect(Category.reflect_on_association(:courses).macro).to eq :has_many
      end
    end
  end
end