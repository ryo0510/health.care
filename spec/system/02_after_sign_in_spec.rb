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

  describe '自分のユーザ詳細画面のテスト' do
    before do
      visit customers_mypage_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/mypage'
      end
      it '自分の会員情報編集リンク先が正しい' do
        expect(page).to have_link '編集する', href: customers_mypage_edit_path
      end
    end
  end

  describe '掲示板画面のテスト' do
    before do
      visit post_messages_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/post_messages'
      end
      it 'ニックネーム入力フォームが表示される' do
        expect(page).to have_field 'post_message[nickname]'
      end
      it 'メッセージ入力フォームが表示される' do
        expect(page).to have_field 'post_message[message]'
      end
    end

    context '投稿成功のテスト' do
      before do
        fill_in 'post_message[nickname]', with: Faker::Lorem.characters(number: 5)
        fill_in 'post_message[message]', with: Faker::Lorem.characters(number: 20)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '新規投稿' }.to change { PostMessage.count }.by(1)
      end
    end
  end
end
