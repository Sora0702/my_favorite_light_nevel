require 'rails_helper'

RSpec.describe "devise registrations", type: :system do
  let!(:user) { create(:user) }

  describe '新規登録画面' do
    before do
      visit new_user_registration_path
    end

    context '新規登録に成功した場合' do
      before do
        fill_in 'new-user-name', with: "test_user"
        fill_in 'new-email', with: "test3@test.com"
        fill_in 'new-password', with: "password"
        fill_in 'confirm-password', with: "password"
        fill_in 'new-introduction', with: "自己紹介"
        find(".new-user-registration").click
      end

      it 'フラッシュメッセージが表示されること' do
        within('.flash-message') do
          expect(page).to have_content "ようこそ！アカウント登録を受け付けました。"
        end
      end

      it 'topページに遷移すること' do
        expect(page).to have_current_path root_path
      end
    end

    context '新規登録に失敗した場合' do
      before do
        fill_in 'new-user-name', with: ""
        fill_in 'new-email', with: ""
        fill_in 'new-password', with: ""
        fill_in 'confirm-password', with: "password"
        fill_in 'new-introduction', with: ""
        find(".new-user-registration").click
      end

      it 'エラーメッセージが表示されること' do
        expect(page).to have_content "名前を入力してください"
        expect(page).to have_content "メールアドレスを入力してください"
        expect(page).to have_content "パスワードを入力してください"
        expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
      end
    end

    it 'アカウントをお持ちの方はこちらを押下した際に新規登録画面に遷移すること' do
      click_on 'アカウントをお持ちの方はこちら'
      expect(page).to have_current_path new_user_session_path
    end
  end

  describe 'アカウント情報編集画面' do
    before do
      login(user)
      visit edit_user_registration_path
    end

    context 'アカウント情報の編集に成功した場合' do
      before do
        fill_in 'edit-email', with: "test2@test.com"
        fill_in 'edit-password', with: "password2"
        fill_in 'edit-confirm-password', with: "password2"
        fill_in 'edit-current-password', with: user.password
        click_on '更新する'
      end

      it 'アカウント情報の編集に成功し、フラッシュメッセージが表示されること' do
        within('.flash-message') do
          expect(page).to have_content "アカウントが更新されました。"
        end
      end

      it 'topページに遷移すること' do
        expect(page).to have_current_path root_path
      end
    end

    context 'アカウント情報の編集に失敗した場合' do
      context 'メールアドレスが未入力の場合' do
        before do
          fill_in 'edit-email', with: ""
          fill_in 'edit-current-password', with: user.password
          click_on '更新する'
        end

        it 'エラーメッセージが表示されること' do
          within(".Error-message") do
            expect(page).to have_content "メールアドレスを入力してください"
          end
        end
      end

      context 'パスワードと確認用パスワードが異なる場合' do
        before do
          fill_in 'edit-password', with: "password2"
          fill_in 'edit-confirm-password', with: "password3"
          fill_in 'edit-current-password', with: user.password
          click_on '更新する'
        end

        it 'エラーメッセージが表示されること' do
          within(".Error-message") do
            expect(page).to have_content "確認用パスワードとパスワードの入力が一致しません"
          end
        end
      end

      context '現在のパスワードが異なる場合' do
        before do
          fill_in 'edit-email', with: "new@test.com"
          fill_in 'edit-password', with: "password2"
          fill_in 'edit-confirm-password', with: "password2"
          fill_in 'edit-current-password', with: "password3"
          click_on '更新する'
        end

        it 'エラーメッセージが表示されること' do
          within(".Error-message") do
            expect(page).to have_content "現在のパスワードは不正な値です"
          end
        end
      end
    end

    it 'キャンセルを押下した際にプロフィール画面に遷移すること' do
      click_on 'キャンセル'
      expect(page).to have_current_path profile_path
    end
  end
end
