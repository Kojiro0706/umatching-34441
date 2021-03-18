require 'rails_helper'
def basic_pass(path)
  username = ENV["BASIC_AUTH_USER"]
  password = ENV["BASIC_AUTH_PASSWORD"]
  visit "http://#{username}:#{password}@#{Capybara.current_session.server.host}:#{Capybara.current_session.server.port}#{path}"
end

RSpec.describe '新規投稿', type: :system do
  before do
    @user= FactoryBot.create(:user)
    @builder= FactoryBot.build(:builder)
  end
  context '投稿ができるとき'do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログインする
      basic_pass new_user_session_path
      visit new_user_session_path
      fill_in 'メールアドレス', with: @user.email
      fill_in 'パスワード（6文字以上）', with: @user.password
      find('input[name="commit"]').click
      # 新規投稿ページへのリンクがあることを確認する
      expect(page).to have_content('POST')
      # 投稿ページに移動する
      visit new_builder_path
      # フォームに情報を入力する
      fill_in 'タイトル', with: @builder.title
      fill_in '説明', with: @builder.description
      select '雑談', from: 'builder[category_id]'
      fill_in 'よく行く競馬場', with: @builder.place
      attach_file '投稿画像', "public/images/test1.png"
      # 送信するとTweetモデルのカウントが1上がることを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Builder.count }.by(1)
      # トップページに遷移することを確認する
      expect(current_path).to eq(root_path)
    end
  end
  context '投稿ができないとき'do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      # トップページに遷移する
      visit root_path
      # 新規投稿ページへのリンクがない
      expect(page).to have_no_content('POST')
    end
  end
end
RSpec.describe '投稿編集', type: :system do
  before do
    @builder1 = FactoryBot.create(:builder)
    @builder2 = FactoryBot.create(:builder)
  end
  context '投稿の編集ができるとき' do
    it 'ログインしたユーザーは自分が投稿したものを編集ができる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @builder1.user.email
      fill_in 'パスワード（6文字以上）', with: @builder1.user.password
      find('input[name="commit"]').click
      # 詳細ページへのリンクが有ることを確認する
      expect(page).to have_content(@builder1.title)
      # 詳細ページへ遷移する
      visit builder_path(@builder1.id)
      # ツイート1に「編集」ボタンがあることを確認する
      expect(page).to have_content('編集')
      # 編集ページへ遷移する
      visit edit_builder_path(@builder1.id)
      # すでに投稿済みの内容がフォームに入っていることを確認する
      expect(find('#builder_title').value).to eq(@builder1.title)
      expect(find('#builder_description').value).to eq(@builder1.description)
      expect(find('#builder_place').value).to eq(@builder1.place)
      # 投稿内容を編集する
      fill_in 'builder_title', with: "#{@builder1.title}+編集"
      fill_in 'builder_description', with: "#{@builder1.description}+編集"
      fill_in 'builder_place', with: "#{@builder1.place}+編集"
      # 編集してもTweetモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Builder.count }.by(0)
      # 詳細画面に遷移したことを確認する
      expect(page).to have_content(@builder1.title)
    end
  end
  context '投稿の編集ができないとき' do
    it 'ログインしたユーザーは自分以外が投稿した投稿の編集画面には遷移できない' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @builder1.user.email
      fill_in 'パスワード（6文字以上）', with: @builder1.user.password
      find('input[name="commit"]').click
      # 投稿2に「編集」ボタンがないことを確認する
      expect(page).to have_content(@builder2.title)
      visit builder_path(@builder2.id)
      expect(page).to have_no_content('編集')
    end
    it 'ログインしていないと投稿のの編集画面には遷移できない' do
      # トップページにいる
      visit root_path
       # 詳細ページへのリンクが有ることを確認する
       expect(page).to have_content(@builder1.title)
       # 詳細ページへ遷移する
       visit builder_path(@builder1.id)
       # 投稿1に「編集」ボタンがあることを確認する
       expect(page).to have_no_content('編集')
       # トップページにいる
       visit root_path
       # 詳細ページへのリンクが有ることを確認する
       expect(page).to have_content(@builder2.title)
       # 詳細ページへ遷移する
       visit builder_path(@builder2.id)
       # 投稿2に「編集」ボタンがあることを確認する
       expect(page).to have_no_content('編集')
    end
  end
  context '投稿が削除ができるとき' do
    it 'ログインしたユーザーは投稿の削除ができる' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @builder1.user.email
      fill_in 'パスワード（6文字以上）', with: @builder1.user.password
      find('input[name="commit"]').click
      # 詳細ページへのリンクが有ることを確認する
      expect(page).to have_content(@builder1.title)
      # 詳細ページへ遷移する
      visit builder_path(@builder1.id)
      # 投稿1に「削除」ボタンがあることを確認する
      expect(page).to have_content('削除')
      # 投稿を削除するとレコードの数が1減ることを確認する
      expect{
        find_link('削除').click
      }.to change { Builder.count }.by(-1)
      # トップページに遷移する
      visit root_path
    end
  end
  context '投稿が削除ができないとき' do
    it 'ログインしたユーザーは自分以外の投稿の削除ができない' do
      # 投稿1を投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @builder1.user.email
      fill_in 'パスワード（6文字以上）', with: @builder1.user.password
      find('input[name="commit"]').click
      # 詳細ページへのリンクが有ることを確認する
      expect(page).to have_content(@builder2.title)
      # 詳細ページへ遷移する
      visit builder_path(@builder2.id)
      # 投稿1に「削除」ボタンがないことを確認する
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないとツイートの削除ボタンがない' do
      # トップページに移動する
      visit root_path
      # 詳細ページへのリンクが有ることを確認する
      expect(page).to have_content(@builder1.title)
      # 詳細ページへ遷移する
      visit builder_path(@builder1.id)
      # 投稿1に「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
      # トップページに移動する
      visit root_path
      # 詳細ページへのリンクが有ることを確認する
      expect(page).to have_content(@builder2.title)
      # 詳細ページへ遷移する
      visit builder_path(@builder2.id)
      # 投稿2に「削除」ボタンが無いことを確認する
      expect(page).to have_no_content('削除')
    end
  end
end
RSpec.describe '詳細ページ', type: :system do
  before do
    @builder = FactoryBot.create(:builder)
  end
  context '投稿の詳細画面に遷移できる' do
    it 'ログインしたユーザーは詳細ページに遷移してコメント投稿欄が表示される' do
      # 投稿したユーザーでログインする
      visit new_user_session_path
      fill_in 'メールアドレス', with: @builder.user.email
      fill_in 'パスワード（6文字以上）', with: @builder.user.password
      find('input[name="commit"]').click
      # 詳細ページへのリンクが有ることを確認する
      expect(page).to have_content(@builder.title)
      # 詳細ページへ遷移する
      visit builder_path(@builder.id)
      # コメント用のフォームが存在する
      expect(page).to have_selector 'form'
    end
  end
  context '投稿の詳細画面に遷移dekinai' do
    it 'ログインしていない状態で詳細ページに飛ぼうとするとログイン画面に遷移する' do
      # トップページに移動する
      visit root_path
      # 詳細ページへのリンクが有ることを確認する
      expect(page).to have_content(@builder.title)
      # 詳細ページへ遷移する
      visit builder_path(@builder.id)
      #ログイン画面に遷移する
      visit user_session_path
    end
  end
end