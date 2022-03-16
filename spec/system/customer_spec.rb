require 'rails_helper'

describe '[STEP1] 会員ログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'ロゴを押すと、トップ画面に遷移する' do
        expect(page).to have_link nil, href: root_path
        click_link nil, href: root_path
        is_expected.to eq '/'
      end
      it '新規登録を押すと、新規登録画面に遷移する' do
        expect(page).to have_link '新規登録', href: new_customer_registration_path
        click_link '新規登録', href: new_customer_registration_path
        is_expected.to eq '/customers/sign_up'
      end
      it 'ログインを押すと、ログイン画面に遷移する' do
        expect(page).to have_link 'ログイン', href: new_customer_session_path
        click_link 'ログイン', href: new_customer_session_path
        is_expected.to eq '/customers/sign_in'
      end
      it '全コース一覧を押すと、全コース一覧画面に遷移する' do
        expect(page).to have_link '全コース一覧', href: courses_path
        click_link '全コース一覧', href: courses_path
        is_expected.to eq '/courses'
      end
    end
  end


end