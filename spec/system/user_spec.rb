require 'rails_helper'
RSpec.describe 'ユーザー管理機能', type: :system do

  describe 'ユーザー登録のテスト' do
    context '新規登録画面でフォームに適正な値を入れた場合' do
      it '新規ユーザーが作成される' do
        visit new_user_registration_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button "新規登録"
        expect(page).to have_content 'アカウント登録が完了しました'
      end
    end
    context '新規登録画面でフォームに不正な値を入れた場合' do
      it 'パスワードが空白だと新規ユーザーが作成されない' do
        visit new_user_registration_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in '確認用パスワード', with: 'password'
        click_button "新規登録"
        expect(page).to have_content 'パスワードを入力してください'
        expect(page).not_to have_content 'アカウント登録が完了しました'
      end
      it 'パスワードと確認用パスワードが一致していないと新規ユーザーが作成されない' do
        visit new_user_registration_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'not_same_password'
        click_button "新規登録"
        expect(page).to have_content '確認用パスワードとパスワードの入力が一致しません'
        expect(page).not_to have_content 'アカウント登録が完了しました'
      end
      it 'メールアドレスが空白だと新規ユーザーが作成されない' do
        visit new_user_registration_path
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button "新規登録"
        expect(page).to have_content 'メールアドレスを入力してください'
        expect(page).not_to have_content 'アカウント登録が完了しました'
      end
      it 'メールアドレスがすでに登録済みだと新規ユーザーが作成されない' do
        visit new_user_registration_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button "新規登録"
        click_on "ログアウト"
        visit new_user_registration_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        fill_in '確認用パスワード', with: 'password'
        click_button "新規登録"
        expect(page).to have_content 'メールアドレスはすでに存在します'
        expect(page).not_to have_content 'アカウント登録が完了しました'
      end
    end
  end

  describe 'ログイン機能' do
    let!(:user) { FactoryBot.create(:user) }
    context 'ログイン画面で適正な値を入れた場合' do
      it 'ログインに成功する' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).to have_content 'ログインしました。'
      end
    end
    context 'ログイン画面で不正な値を入れた場合' do
      it '登録していないメールアドレスだとログインできない' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'not_test@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        expect(page).not_to have_content 'ログインしました。'
        expect(page).to have_content 'パスワードをお忘れですか？'
      end
      it '登録済みメールアドレスでもパスワードが違うとログインできない' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'not_password'
        click_button 'ログイン'
        expect(page).not_to have_content 'ログインしました。'
        expect(page).to have_content 'パスワードをお忘れですか？'
      end
    end
  end
    
  describe 'ログイン中の機能' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:admin_user) { FactoryBot.create(:admin_user) }
    context '一般ユーザーでログインした場合' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end
      it 'ログインに成功するとログイン中専用TOPページが表示される' do
        expect(page).to have_content 'ようこそGuardiantへ！！'
        expect(page).not_to have_content 'Guardiant」は防災対策について管理・出力する総合防災アプリです。'
      end
      it 'ログアウトをすると非ログイン者用TOPページが表示される' do
        click_on 'ログアウト'
        expect(page).not_to have_content 'ようこそGuardiantへ！！'
        expect(page).to have_content 'Guardiant」は防災対策について管理・出力する総合防災アプリです。'
      end
      it '管理者専用ページへのリンクは表示されない' do
        expect(page).to have_content 'ようこそGuardiantへ！！'
        expect(page).not_to have_content '管理者専用ページへ'
      end
      it '管理者専用ページへアクセスできない' do
        visit rails_admin_path
        expect(page).not_to have_content 'サイト管理'
        expect(page).not_to have_content 'Guardiant Admin'
        expect(page).to have_content 'ようこそGuardiantへ！！'
      end
      it 'アカウント情報を編集できる' do
        expect(page).to have_content 'ようこそGuardiantへ！！'
        click_on 'アカウント情報編集'
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'next_password'
        fill_in '確認用パスワード', with: 'next_password'
        fill_in '現在のパスワード', with: 'password'
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
      it 'アカウントを削除できる' do
        expect(page).to have_content 'ようこそGuardiantへ！！'
        click_on 'アカウント情報編集'
        page.accept_confirm do
          click_button 'アカウントを削除する'
        end
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end
    end

    context '管理ユーザーでログインした場合' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'admintest@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
      end
      it 'ログインに成功するとログイン中専用TOPページが表示される' do
        expect(page).to have_content 'ようこそGuardiantへ！！'
        expect(page).not_to have_content 'Guardiant」は防災対策について管理・出力する総合防災アプリです。'
      end
      it 'ログアウトをすると非ログイン者用TOPページが表示される' do
        click_on 'ログアウト'
        expect(page).not_to have_content 'ようこそGuardiantへ！！'
        expect(page).to have_content 'Guardiant」は防災対策について管理・出力する総合防災アプリです。'
      end
      it '管理者専用ページへのリンクが表示される' do
        expect(page).to have_content 'ようこそGuardiantへ！！'
        expect(page).to have_content '管理者専用ページへ'
      end
      it '管理者専用ページへアクセスできる' do
        visit rails_admin_path
        expect(page).to have_content 'サイト管理'
        expect(page).to have_content 'Guardiant Admin'
      end
      it 'アカウント情報を編集できる' do
        expect(page).to have_content 'ようこそGuardiantへ！！'
        click_on 'アカウント情報編集'
        fill_in 'メールアドレス', with: 'admintest@sample.com'
        fill_in 'パスワード', with: 'next_password'
        fill_in '確認用パスワード', with: 'next_password'
        fill_in '現在のパスワード', with: 'password'
        click_button '変更する'
        expect(page).to have_content 'アカウント情報を変更しました。'
      end
      it 'アカウントを削除できる' do
        expect(page).to have_content 'ようこそGuardiantへ！！'
        click_on 'アカウント情報編集'
        page.accept_confirm do
          click_button 'アカウントを削除する'
        end
        expect(page).to have_content 'アカウントを削除しました。またのご利用をお待ちしております。'
      end
    end
  end


end