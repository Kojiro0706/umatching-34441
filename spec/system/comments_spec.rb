require 'rails_helper'
def basic_pass(path)
  username = ENV['BASIC_AUTH_USER']
  password = ENV['BASIC_AUTH_PASSWORD']
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe 'コメント投稿', type: :system do
  before do
    @builder = FactoryBot.create(:builder)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーはツイート詳細ページでコメント投稿できる' do
    # ログインする
    # 投稿したユーザーでログインする
    basic_pass new_user_session_path
    visit new_user_session_path
    fill_in 'メールアドレス', with: @builder.user.email
    fill_in 'パスワード（6文字以上）', with: @builder.user.password
    find('input[name="commit"]').click
    # ツイート詳細ページに遷移する
    visit builder_path(@builder)
    # フォームに情報を入力する
    fill_in 'comment_text', with: @comment
    # コメントを送信する
    click_button 'SEND'
    # 詳細ページ上に先ほどのコメント内容が含まれていることを確認する
    expect(page).to have_content @comment
  end
end
