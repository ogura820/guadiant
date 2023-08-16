require 'rails_helper'
RSpec.describe '必要備蓄量計算機能', type: :system do
  describe 'CRUD機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'test@sample.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      visit stockpiles_path
      click_on "新規登録"
      fill_in '電池・お酒など', with: '電池'
      click_on "投稿する"
    end
    context '新規登録画面でフォームに適正な値を入れた場合' do
      it 'DBに保存され一覧画面に表示される' do
        expect(page).to have_content('登録できました')
        expect(page).to have_content('電池')
      end
    end
    context '一覧画面で編集ボタンを押した場合' do
      it '値が正しければ情報を編集できる' do
        find('tr', text: '電池').click_on "編集"
        fill_in 'stockpile[name]', with: '携帯トイレ'
        click_on "更新する"
        expect(page).to have_content '情報を編集しました！'   
        expect(page).to have_content '携帯トイレ'     
        expect(page).not_to have_content '電池'   
      end
      it '値が正しくなければ情報を編集できない' do
        find('tr', text: '電池').click_on "編集"
        fill_in 'stockpile[name]', with: ''
        click_on "更新する"
        expect(page).to have_content '更新に失敗しました。空白では更新できません'  
        expect(page).to have_content '電池'     
      end
    end
    context '一覧画面で削除ボタンを押した場合' do
      it '削除される' do
        page.accept_confirm do
          find('tr', text: '電池').click_on "削除"
        end
        expect(page).not_to have_content '電池'  
        expect(page).to have_content '削除できました'     
      end
    end
  end
  describe 'ユーザー切り分けのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:id_user) { FactoryBot.create(:id_user) }
    let!(:stockpile2) { FactoryBot.create(:stockpile2) }
    context '一覧画面にアクセスした場合' do
      it '一覧画面に他のユーザーの作成したメンバーは表示されない' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        visit stockpiles_path
        expect(page).not_to have_content('ビデオゲーム')
      end
    end
  end
end