require 'rails_helper'

RSpec.describe 'ユーザー管理機能', type: :system do
  describe 'ユーザー登録機能' do
    context 'ユーザーを新規作成した場合' do
      it '登録したユーザーが表示できること' do
        visit new_user_path
        fill_in '名前', with: '太郎'
        fill_in 'メールアドレス', with: 'taro@sample.com'
        fill_in 'パスワード', with: '222222'
        fill_in '確認用パスワード', with: '222222'
        click_on '登録'
        expect(page).to have_content '太郎'
        expect(page).to have_content 'taro@sample.com'
      end
    end
    context 'ユーザがログインせずタスク一覧画面に飛ぼうとしたとき' do
      it 'ログイン画面に遷移すること' do
        visit tasks_path
        expect(current_path).to eq new_session_path
      end
    end
  end
  describe 'セッション機能' do
    before do
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:second_user)
    end
    context 'ユーザーを入力した場合' do
      it 'ログインができること' do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on 'Log in'
        expect(current_path).to eq user_path(id: @user.id)
      end
    end
    context 'ログインしている時' do
      before do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on 'Log in'
      end
      it '自分の詳細画面に飛べること' do
        visit user_path(id: @user.id)
        expect(current_path).to eq user_path(id: @user.id)
      end
      it '一般ユーザが他人の詳細画面に飛ぶとタスク一覧画面に遷移すること' do
        visit user_path(2)
        expect(current_path).to eq tasks_path
      end
      it 'ログアウトができること' do
        visit user_path(id: @user.id)
        click_link 'Logout'
        expect(page).to have_content 'ログアウトしました'
      end
    end
  end
  describe '管理画面のテスト' do
    before do
      @user = FactoryBot.create(:user)
      @second_user = FactoryBot.create(:second_user)
    end
    context '管理ユーザーの場合'do
      it '管理画面にアクセスできること' do
        visit new_session_path
        fill_in 'session_email', with: @second_user.email
        fill_in 'session_password', with: @second_user.password
        click_on 'Log in'
        visit admin_users_path
        expect(current_path).to eq admin_users_path
      end
    end
    context '一般ユーザーの場合'do
      it '管理画面にアクセスできないこと' do
        visit new_session_path
        fill_in 'session_email', with: @user.email
        fill_in 'session_password', with: @user.password
        click_on 'Log in'
        visit admin_users_path
        expect(page).to have_content '管理者以外はアクセスできません'
      end
    end
    context '管理ユーザーの場合' do
      before do
        visit new_session_path
        fill_in 'session_email', with: @second_user.email
        fill_in 'session_password', with: @second_user.password
        click_on 'Log in'
      end
      it 'ユーザーの新規登録ができること' do
        visit new_admin_user_path
        fill_in '名前', with: 'sample2'
        fill_in 'メールアドレス', with: 'sample2@sample.com'
        fill_in 'パスワード', with: '123456'
        fill_in '確認用パスワード', with: '123456'
        click_on '登録'
        expect(page).to have_content 'ユーザー登録しました.'
      end
      it 'ユーザーの詳細画面にアクセスできること' do
        visit admin_user_path(id: @user.id)
        expect(current_path).to include admin_user_path(id: @user.id)
      end
      it 'ユーザーの編集画面からユーザーを編集できること' do
        visit edit_admin_user_path(@user.id)
        fill_in '名前', with: 'sample2'
        fill_in 'メールアドレス', with: 'sample2@sample.com'
        fill_in 'パスワード', with: '123456'
        fill_in '確認用パスワード', with: '123456'
        click_on '更新'
        expect(page).to have_content '編集しました.'
      end
      it 'ユーザーの削除ができること' do
        visit admin_users_path
        click_link '削除', match: :first
        page.driver.browser.switch_to.alert.accept
        expect(page).to have_content 'ユーザーを削除しました.'
      end
    end
  end
end
# bundle exec rspec spec/system/user_spec.rb