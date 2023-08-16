require 'rails_helper'
RSpec.describe '必要備蓄量計算機能', type: :system do
  describe 'CRUD機能のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    before do
      visit new_user_session_path
      fill_in 'メールアドレス', with: 'test@sample.com'
      fill_in 'パスワード', with: 'password'
      click_button 'ログイン'
      visit families_path
      click_on "新規作成"
      fill_in '自分・夫・妻など', with: '猫型ロボット'
      select '男性', from: 'family[sex]'
      fill_in 'family_age', with: '52'
      select '中食が多い', from: 'family[diet]'
      click_on "投稿する"
    end
    context '新規作成画面でフォームに適正な値を入れた場合' do
      it 'DBに保存され一覧画面に表示される' do
        expect(page).to have_content('算出用ユーザー作成に成功しました')
        expect(page).to have_content('猫型ロボット')
        expect(page).to have_content('52歳')   
      end
    end
    context '一覧画面で編集ボタンを押した場合' do
      it '値が正しければ情報を編集できる' do
        click_on "編集"
        fill_in 'family[name]', with: '長男'
        click_on "更新する"
        expect(page).to have_content '長男'  
        expect(page).not_to have_content '猫型ロボット'     
      end
      it '値が正しくなければ情報を編集できない' do
        click_on "編集"
        fill_in 'family[name]', with: ''
        click_on "更新する"
        expect(page).to have_content '更新に失敗しました。空白では更新できません'  
        expect(page).to have_content '猫型ロボット'     
      end
    end
    context '一覧画面で削除ボタンを押した場合' do
      it '算出用メンバーが削除される' do
        page.accept_confirm do
          click_on "削除"
        end
        expect(page).not_to have_content '猫型ロボット'  
        expect(page).to have_content '算出用ユーザーの削除に成功しました'  
        expect(page).to have_content '現在メンバーは'     
      end
    end
  end
  describe 'ユーザー切り分けのテスト' do
    let!(:user) { FactoryBot.create(:user) }
    let!(:id_user) { FactoryBot.create(:id_user) }
    let!(:family2) { FactoryBot.create(:family2) }
    context '一覧画面にアクセスした場合' do
      it '一覧画面に他のユーザーの作成したメンバーは表示されない' do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        visit families_path
        expect(page).to have_content('現在メンバーは0人です')
        expect(page).not_to have_content('次女')
      end
    end
  end
  describe '必要備蓄量のテスト' do
    let!(:user) { FactoryBot.create(:user) }
    context '算出用メンバー０人でアクセスした場合' do
      before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'test@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        visit families_path
      end
      it '一覧画面に必要物資表示をするボタンは表示されない' do
        expect(page).to have_content('現在メンバーは0人です')
        expect(page).not_to have_content('必要物資表示')
      end
      it '一覧画面に使い方が表示される' do
        expect(page).to have_content('現在メンバーは0人です')
        expect(page).to have_content('使い方')
      end
    end
    context '算出用メンバーが存在してるときにアクセスした場合' do
      let!(:id_user) { FactoryBot.create(:id_user) }
      let!(:family2) { FactoryBot.create(:family2) }
        before do
        visit new_user_session_path
        fill_in 'メールアドレス', with: 'admintest@sample.com'
        fill_in 'パスワード', with: 'password'
        click_button 'ログイン'
        visit families_path
      end
      it '一覧画面に必要物資表示をするボタンは表示される' do
        expect(page).to have_content('必要物資表示')
        expect(page).to have_content('現在メンバーは1人です')
      end
      it '一覧画面に使い方が表示されない' do
        expect(page).to have_content('現在メンバーは1人です')
        expect(page).not_to have_content('使い方')
      end
      it '必要物資を表示するボタンを押すと表示される' do
        click_on '必要物資表示'
        expect(page).to have_content('二週間分の必要備蓄量です')
      end
      it '必要物資をメールで受け取れる' do
        click_on '必要物資表示'
        click_on '必要物資のメールを送る'
        expect(page).to have_content('メール送信しました')
      end
    end
  end
end