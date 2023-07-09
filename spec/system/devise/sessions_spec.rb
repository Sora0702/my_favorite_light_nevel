require 'rails_helper'

RSpec.describe "devise sessions", type: :system do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user, email: "test2@test.com", password: "password2") }

  before do
    visit new_user_session_path
  end

  describe 'ログイン画面' do
    context '正常にログインした場合' do
      before do
        login(user)
      end

      it 'ログイン成功のフラッシュメッセージが表示されること' do
        within('.flash-message') do
          expect(page).to have_content "ログインしました。"
        end
      end

      it 'topページに遷移すること' do
        expect(page).to have_current_path root_path
      end
    end

    context 'ログインに失敗した場合' do
      context 'メールアドレスが空欄の場合' do
        before do
          fill_in 'メールアドレス', with: ""
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
        end

        it 'エラーメッセージが表示されること' do
          within('.alert') do
            expect(page).to have_content "メールアドレスかパスワードが違います。"
          end
        end
      end

      context 'メールアドレスが異なる場合' do
        before do
          fill_in 'メールアドレス', with: other_user.email
          fill_in 'パスワード', with: user.password
          click_button 'ログイン'
        end

        it 'エラーメッセージが表示されること' do
          within('.alert') do
            expect(page).to have_content "メールアドレスかパスワードが違います。"
          end
        end
      end

      context 'パスワードが空欄の場合' do
        before do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: ""
          click_button 'ログイン'
        end
        
        it 'エラーメッセージが表示されること' do
          within('.alert') do
            expect(page).to have_content "メールアドレスまたはパスワードが無効です。"
          end
        end
      end

      context 'パスワードが異なる場合' do
        before do
          fill_in 'メールアドレス', with: user.email
          fill_in 'パスワード', with: other_user.password
          click_button 'ログイン'
        end
        
        it 'エラーメッセージが表示されること' do
          within('.alert') do
            expect(page).to have_content "メールアドレスかパスワードが違います。"
          end
        end
      end
    end

    it '新規登録の方はこちらを押下した際に新規登録画面に遷移すること' do
      click_on '新規登録の方はこちら'
      expect(page).to have_current_path new_user_registration_path
    end
  end
end
