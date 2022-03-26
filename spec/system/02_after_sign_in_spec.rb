require 'rails_helper'

describe '[STEP2] 会員ログイン後のテスト' do
  let(:customer) { create(:customer) }
  let!(:category) { create(:category) }
  let!(:course) { create(:course, category_id: category.id) }
  let!(:entry) { create(:entry, customer_id: customer.id, course_id: course.id) }
  let!(:course_result) { create(:course_result, entry_id: entry.id) }
  let!(:history) { create(:history, customer_id: customer.id, course_result_id: course_result.id) }

  before do
    visit new_customer_session_path
    fill_in 'customer[email]', with: customer.email
    fill_in 'customer[password]', with: customer.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済み。' do
      subject { current_path }

      it 'ロゴを押すと、トップ画面に遷移する' do
        expect(page).to have_link nil, href: root_path
        click_link nil, href: root_path
        is_expected.to eq '/'
      end
      it 'マイページを押すと、マイページ画面に遷移する' do
        expect(page).to have_link 'マイページ', href: customers_mypage_path
        click_link 'マイページ', href: customers_mypage_path
        is_expected.to eq '/customers/mypage'
      end
      it '掲示板を押すと、掲示板画面に遷移する' do
        expect(page).to have_link '掲示板', href: post_messages_path
        click_link '掲示板', href: post_messages_path
        is_expected.to eq '/post_messages'
      end
      it '全コース一覧を押すと、全コース一覧画面に遷移する' do
        expect(page).to have_link '全コース一覧', href: courses_path
        click_link '全コース一覧', href: courses_path
        is_expected.to eq '/courses'
      end
      it 'コース設定を押すと、コース選択画面に遷移する' do
        expect(page).to have_link 'コース設定', href: new_entry_path
        click_link 'コース設定', href: new_entry_path
        is_expected.to eq '/entries/new'
      end
      it '記録を押すと、選択コース一覧画面に遷移する' do
        expect(page).to have_link '記録', href: entries_path
        click_link '記録', href: entries_path
        is_expected.to eq '/entries'
      end
      it 'ログアウトを押すと、トップ画面に遷移する' do
        expect(page).to have_link 'ログアウト', href: destroy_customer_session_path
        click_link 'ログアウト', href: destroy_customer_session_path
        is_expected.to eq '/'
      end
    end
  end
end
