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
    end
    context '新規作成画面で住所フォームに適正な値を入れた場合' do
      before do
        visit maps_path
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
  end

end