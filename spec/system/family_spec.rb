require 'rails_helper'
RSpec.describe '必要備蓄量計算機能', type: :system do
  describe 'CRD機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'test@sample.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      visit families_path
    end
    context '新規作成画面でフォームに適正な値を入れた場合' do
      before do
        click_on "新規作成"
        fill_in '自分・夫・妻など', with: '猫型ロボット'
        select '男性', from: 'family[sex]'
        fill_in 'family_age', with: '52'
        select '中食が多い', from: 'family[diet]'
        click_on "投稿する"
      end
      it 'DBに保存され一覧画面に表示される' do
        expect(page).to have_content('算出用ユーザー作成に成功しました')
        expect(page).to have_content('猫型ロボット')
        expect(page).to have_content('52歳')   
      end
    end
    context '一覧画面で編集ボタンを押した場合' do
      before do
        click_on "新規作成"
        fill_in '自分・夫・妻など', with: '長男'
        select '男性', from: 'family[sex]'
        fill_in 'family_age', with: '52'
        select '中食が多い', from: 'family[diet]'
        click_on "投稿する"
      end
      it '値が正しければ情報を編集できる' do
        click_on "編集"
        fill_in 'family[name]', with: '猫型ロボット'
        click_on "更新する"
        visit families_path
        expect(page).to have_content '猫型ロボット'  
        expect(page).not_to have_content '長男'     
      end
    end
    # context '一覧画面で削除ボタンを押した場合' do
    #   it '地図が削除される' do
    #     page.accept_confirm do
    #       click_on "削除"
    #     end
    #     expect(page).to have_content '削除しました'  
    #     expect(page).to have_content '避難場所一覧'     
    #   end
    # end
    # context '他のユーザーの地図を見ようとした場合' do
    #   let!(:map_user) { FactoryBot.create(:map_user) }
    #   let!(:map2) { FactoryBot.create(:map2) }
    #   it '地図が表示されない' do
    #     click_on "地図表示"
    #     visit maps_path(2)
    #     expect(page).not_to have_content '地図の読み方'    
    #   end
    # end
  end

end