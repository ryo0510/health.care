RSpec.describe 'Courseモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { course.valid? }

    let(:category) { create(:category) }
    let(:course) { build(:course, category_id: category.id) }
    let!(:other_course) { create(:course, category_id: category.id) }

    context 'category_idカラム' do
      it '空欄でないこと' do
        course.category_id = ''
        expect(subject).to eq false
      end
    end

    context 'nameカラム' do
      it '空欄でないこと' do
        course.name = ''
        expect(subject).to eq false
      end
      it '一意性があること' do
        course.name = other_course.name
        expect(subject).to eq false
      end
      it '15文字以下であること: 15文字は〇' do
        course.name = Faker::Lorem.characters(number: 15)
        expect(subject).to eq true
      end
      it '15文字以下であること: 16文字は×' do
        course.name = Faker::Lorem.characters(number: 16)
        expect(subject).to eq false
      end
    end

    context 'working_itemカラム' do
      it '空欄でないこと' do
        course.working_item = ''
        expect(subject).to eq false
      end
    end

    context 'target_dateカラム' do
      it '空欄でないこと' do
        course.target_date = ''
        expect(subject).to eq false
      end
      it '数字以外は登録できないこと' do
        course.target_date = Faker::Lorem.characters(number: 10)
        expect(subject).to eq false
      end
      it '数字は登録できること' do
        course.target_date = '10'
        expect(subject).to eq true
      end
      it '1以上であること: 0は×' do
        course.target_date = '0'
        expect(subject).to eq false
      end
    end
  end

   describe 'アソシエーションのテスト' do
    context 'Entryモデルとの関係' do
      it '1:Nとなっている' do
        expect(Course.reflect_on_association(:entries).macro).to eq :has_many
      end
    end

    context 'Categoryモデルとの関係' do
      it 'N:1となっている' do
        expect(Course.reflect_on_association(:category).macro).to eq :belongs_to
      end
    end
  end
end