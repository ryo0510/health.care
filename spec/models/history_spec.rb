require 'rails_helper'

RSpec.describe 'Historyモデルのテスト', type: :model do
  describe 'バリデーションのテスト' do
    subject { history.valid? }

    let(:customer) { create(:customer) }
    let(:course) { create(:course, category_id: category.id) }
    let(:entry) { create(:entry, customer_id: customer.id, course_id: course.id) }
    let(:course_result) { create(:course_result, entry_id: entry.id) }
    let!(:history) { build(:history, customer_id: customer.id, course_result_id: course_result.id) }

    context 'resultカラム' do
      it '空欄でないこと' do
        history.name = ''
        expect(subject).to eq false
      end
    end

    context 'memoカラム' do
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