require 'rails_helper'
RSpec.describe 'ユーザーモデル機能', type: :model do
  describe 'バリデーションのテスト' do
    context 'ユーザーのメールアドレスが空の場合' do
      it 'バリデーションにひっかる' do
        user = User.new(email: '')
        expect(user).not_to be_valid
      end
    end
    context 'ユーザーのパスワードが空の場合' do
      it 'バリデーションにひっかかる' do
        user = User.new(password: '')
        expect(user).not_to be_valid
      end
    end
    context 'メールアドレス・パスワードに内容が記載されている場合' do
      it 'バリデーションが通る' do
        user = User.new(email: 'test@sample.com', password: 'testtest')
        expect(user).to be_valid
      end
    end
    context 'ユーザーのメールアドレスに@がない場合' do
      it 'バリデーションにひっかる' do
        user = User.new(email: 'testsample.com', password: '123456')
        expect(user).not_to be_valid
      end
    end
    context 'パスワードが5文字以下の場合' do
      it 'バリデーションにひっかる' do
        user = User.new(email: 'test@sample.com', password: '12345')
        expect(user).not_to be_valid
        user = User.new(email: 'test@sample.com', password: '1234')
        expect(user).not_to be_valid
        user = User.new(email: 'test@sample.com', password: '123')
        expect(user).not_to be_valid
        user = User.new(email: 'test@sample.com', password: '12')
        expect(user).not_to be_valid
        user = User.new(email: 'test@sample.com', password: '1')
        expect(user).not_to be_valid
      end
    end
  end
end