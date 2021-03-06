require 'rails_helper'

describe '[STEP1] 会員ログイン前のテスト' do
  describe 'トップ画面のテスト' do
    before do
      visit root_path
    end

    context 'リンクの内容を確認' do
      subject { current_path }

      it 'URLが正しい' do
        expect(current_path).to eq '/'
      end
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

  describe '会員新規登録' do
    before do
      visit new_customer_registration_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_up'
      end
      it '「新規登録」と表示される' do
        expect(page).to have_content '新規会員登録'
      end
      it 'last_nameフォームが表示される' do
        expect(page).to have_field 'customer[last_name]'
      end
      it 'first_nameフォームが表示される' do
        expect(page).to have_field 'customer[first_name]'
      end
      it 'last_name_kanaフォームが表示される' do
        expect(page).to have_field 'customer[last_name_kana]'
      end
      it 'first_name_kanaフォームが表示される' do
        expect(page).to have_field 'customer[first_name_kana]'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'telフォームが表示される' do
        expect(page).to have_field 'customer[tel]'
      end
      it 'addressフォームが表示される' do
        expect(page).to have_field 'customer[address]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'password_confirmationフォームが表示される' do
        expect(page).to have_field 'customer[password_confirmation]'
      end
      it '新規登録ボタンが表示される' do
        expect(page).to have_button '新規登録'
      end
    end

    context '新規登録成功のテスト' do
      before do
        fill_in 'customer[last_name]', with: '山田'
        fill_in 'customer[first_name]', with: '太郎'
        fill_in 'customer[last_name_kana]', with: 'ヤマダ'
        fill_in 'customer[first_name_kana]', with: 'タロウ'
        fill_in 'customer[email]', with: Faker::Internet.email
        fill_in 'customer[tel]', with: Faker::Number.number(digits: 11)
        fill_in 'customer[address]', with: Faker::Address.full_address
        fill_in 'customer[password]', with: 'password'
        fill_in 'customer[password_confirmation]', with: 'password'
      end
      it '正しく新規登録される' do
        expect { click_button '新規登録' }.to change { Customer.count }.by(1)
      end
      it '新規登録後のリダイレクト先が、新規登録できたユーザの詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/customers/mypage'
      end
    end
  end

  describe 'ログイン' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/customers/sign_in'
      end
      it '「ログイン」と表示される' do
        expect(page).to have_content 'ログイン'
      end
      it '「ゲストログイン（閲覧用）」と表示される' do
        expect(page).to have_content 'ゲストログイン（閲覧用）'
      end
      it 'emailフォームが表示される' do
        expect(page).to have_field 'customer[email]'
      end
      it 'passwordフォームが表示される' do
        expect(page).to have_field 'customer[password]'
      end
      it 'ログインボタンが表示される' do
        expect(page).to have_button 'ログイン'
      end
    end

    context 'ログイン成功のテスト' do
      before do
        fill_in 'customer[email]', with: customer.email
        fill_in 'customer[password]', with: customer.password
        click_button 'ログイン'
      end

      it 'ログイン後のリダイレクト先が、トップページになっている' do
        expect(current_path).to eq '/'
      end
    end

    # context 'ゲストログイン成功のテスト' do
    #   it 'ログイン後のリダイレクト先が、トップページになっている' do
    #     expect(page).to have_link 'ゲストログイン（閲覧用）', href: customers_guest_sign_in_path
    #     click_link 'ゲストログイン（閲覧用）', href: customers_guest_sign_in_path
    #     is_expected.to eq '/'
    #   end
    # end

    context 'ログイン失敗のテスト' do
      before do
        fill_in 'customer[email]', with: ''
        fill_in 'customer[password]', with: ''
        click_button 'ログイン'
      end

      it 'ログインに失敗し、ログイン画面にリダイレクトされる' do
        expect(current_path).to eq '/customers/sign_in'
      end
    end
  end

  describe 'ログアウトのテスト' do
    let(:customer) { create(:customer) }

    before do
      visit new_customer_session_path
      fill_in 'customer[email]', with: customer.email
      fill_in 'customer[password]', with: customer.password
      click_button 'ログイン'
    end

    context 'ログアウト機能のテスト' do
      it '正しくログアウトできている' do
        expect(page).to have_link 'ログアウト', href: destroy_customer_session_path
        click_link 'ログアウト', href: destroy_customer_session_path
      end
      it 'ログアウト後のリダイレクト先が、トップになっている' do
        expect(current_path).to eq '/'
      end
    end
  end
end