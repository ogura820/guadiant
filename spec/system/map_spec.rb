require 'rails_helper'
RSpec.describe '避難場所検索機能', type: :system do
  describe 'CRD機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:map) { FactoryBot.create(:map) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'test@sample.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      visit maps_path
    end
    context '新規作成画面で住所フォームに適正な値を入れた場合' do
      before do
        click_on "新規作成"
        fill_in '名前', with: '自宅'
        fill_in 'Address', with: '東京都千代田区1-1-1'
      end
      it '緯度と経度が自動的に入力される' do
        expect(page).to have_field('緯度', with: '35.68735')
        expect(page).to have_field('経度', with: '139.741509')
        expect(page).not_to have_field('緯度', with: '')
        expect(page).not_to have_field('経度', with: '')        
      end
      it '緯度と経度が自動的に入力されてDBに保存できる' do
        click_on "投稿する"
        expect(page).to have_content '避難場所を登録しました'
        expect(page).to have_content '自宅'
      end
    end
    context '一覧画面で詳細ボタンを押した場合' do
      it '地図が表示される' do
        click_on "地図表示"
        expect(page).to have_selector('div.geolonia')
        expect(page).to have_content '地図の読み方'  
        expect(page).to have_content '仮地名'     
      end
    end
    context '一覧画面で削除ボタンを押した場合' do
      it '地図が削除される' do
        page.accept_confirm do
          click_on "削除"
        end
        expect(page).to have_content '削除しました'  
        expect(page).to have_content '避難場所一覧'     
      end
    end
    context '他のユーザーの地図を見ようとした場合' do
      let!(:id_user) { FactoryBot.create(:id_user) }
      let!(:map2) { FactoryBot.create(:map2) }
      it '地図が表示されない' do
        click_on "地図表示"
        visit maps_path(2)
        expect(page).not_to have_content '地図の読み方'    
      end
    end
  end

end