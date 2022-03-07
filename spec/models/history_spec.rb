require 'rails_helper'

RSpec.describe 'Historyモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { history.valid? }

    let(:customer) { create(:customer) }
    let(:category) { create(:category) }
    let(:course) { create(:course, category_id: category.id) }
    let(:entry) { create(:entry, customer_id: customer.id, course_id: course.id) }
    let(:course_result) { create(:course_result, entry_id: entry.id) }
    let!(:history) { build(:history, customer_id: customer.id, course_result_id: course_result.id) }
    let!(:other_history) { create(:history, customer_id: customer.id, course_result_id: course_result.id) }

    context 'customer_idカラム' do
      it '空欄でないこと' do
        history.customer_id = ''
        expect(subject).to eq false
      end
    end

    context 'course_result_idカラム' do
      it '空欄でないこと' do
        history.course_result_id = ''
        expect(subject).to eq false
      end
    end

    context 'resultカラム' do
      it '空欄でないこと' do
        history.result = ''
        expect(subject).to eq false
      end
    end

    context 'memoカラム' do
      it '140文字以下であること: 140文字は〇' do
        history.memo = Faker::Lorem.characters(number: 140)
        is_expected.to eq true
      end
      it '140文字以下であること: 141文字は×' do
        history.memo = Faker::Lorem.characters(number: 141)
        is_expected.to eq false
      end
    end

    context 'start_timeカラム' do
      it '空欄でないこと' do
        history.start_time = ''
        expect(subject).to eq false
      end
      it '一意性があること' do
        history.start_time = other_history.start_time
        expect(subject).to eq false
      end
    end
  end

  describe 'アソシエーションのテスト' do
    context 'Customerモデルとの関係' do
      it 'N:1となっている' do
        expect(History.reflect_on_association(:customer).macro).to eq :belongs_to
      end
    end

    context 'CourseResultモデルとの関係' do
      it 'N:1となっている' do
        expect(History.reflect_on_association(:course_result).macro).to eq :belongs_to
      end
    end
  end
end