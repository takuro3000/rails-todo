require 'rails_helper'

RSpec.describe 'Todos', type: :system do
  describe 'タスク一覧ページ' do
    context 'タスクが存在しない場合' do
      it '空の状態メッセージが表示されること' do
        visit todos_path

        expect(page).to have_content('タスク一覧')
        expect(page).to have_content('タスクがありません')
      end
    end

    context 'タスクが存在する場合' do
      let!(:todo) { Todo.create!(title: 'テストタスク', description: '説明文', completed: false) }

      it 'タスクが一覧に表示されること' do
        visit todos_path

        expect(page).to have_content('テストタスク')
      end

      it '統計情報が表示されること' do
        Todo.create!(title: '完了タスク', completed: true)
        visit todos_path

        expect(page).to have_content('全タスク')
        expect(page).to have_content('完了')
        expect(page).to have_content('未完了')
      end
    end
  end

  describe 'タスク作成' do
    it '新しいタスクを作成できること' do
      visit new_todo_path

      fill_in 'タイトル', with: '新しいタスク'
      fill_in '説明', with: 'これは新しいタスクの説明です'
      click_button 'タスクを作成'

      expect(page).to have_content('Todo was successfully created.')
      expect(page).to have_content('新しいタスク')
      expect(page).to have_content('これは新しいタスクの説明です')
    end

    it 'タイトルが空の場合はエラーが表示されること' do
      visit new_todo_path

      fill_in 'タイトル', with: ''
      click_button 'タスクを作成'

      expect(page).to have_content('エラーがあります')
    end

    it '一覧ページから新規作成ページに遷移できること' do
      visit todos_path

      click_link '新しいタスク'

      expect(current_path).to eq(new_todo_path)
    end
  end

  describe 'タスク詳細' do
    let!(:todo) { Todo.create!(title: '詳細テスト', description: '詳細説明', completed: false) }

    it 'タスクの詳細が表示されること' do
      visit todo_path(todo)

      expect(page).to have_content('詳細テスト')
      expect(page).to have_content('詳細説明')
      expect(page).to have_content('未完了')
    end

    it '一覧ページに戻れること' do
      visit todo_path(todo)

      click_link '一覧に戻る'

      expect(current_path).to eq(todos_path)
    end
  end

  describe 'タスク編集' do
    let!(:todo) { Todo.create!(title: '編集前タスク', description: '編集前説明', completed: false) }

    it 'タスクを編集できること' do
      visit edit_todo_path(todo)

      fill_in 'タイトル', with: '編集後タスク'
      fill_in '説明', with: '編集後説明'
      click_button 'タスクを更新'

      expect(page).to have_content('Todo was successfully updated.')
      expect(page).to have_content('編集後タスク')
      expect(page).to have_content('編集後説明')
    end

    it '完了状態を変更できること' do
      visit edit_todo_path(todo)

      check '完了済み'
      click_button 'タスクを更新'

      expect(page).to have_content('完了')
    end

    it '詳細ページから編集ページに遷移できること' do
      visit todo_path(todo)

      click_link '編集'

      expect(current_path).to eq(edit_todo_path(todo))
    end
  end

  describe 'タスク削除' do
    let!(:todo) { Todo.create!(title: '削除対象タスク', completed: false) }

    it 'タスクを削除できること' do
      visit todo_path(todo)

      click_button '削除'

      expect(page).to have_content('Todo was successfully destroyed.')
      expect(page).not_to have_content('削除対象タスク')
      expect(current_path).to eq(todos_path)
    end
  end

  describe 'タスクの一連の操作フロー' do
    it '作成→編集→完了→削除の一連の操作ができること' do
      # 1. タスクを作成
      visit new_todo_path
      fill_in 'タイトル', with: 'フロータスク'
      fill_in '説明', with: 'フローテスト用'
      click_button 'タスクを作成'

      expect(page).to have_content('Todo was successfully created.')
      expect(page).to have_content('フロータスク')

      # 2. 編集ページに移動
      click_link '編集'
      expect(current_path).to match(%r{/todos/\d+/edit})

      # 3. タスクを完了に変更
      check '完了済み'
      click_button 'タスクを更新'

      expect(page).to have_content('Todo was successfully updated.')
      expect(page).to have_content('完了')

      # 4. タスクを削除
      click_button '削除'

      expect(page).to have_content('Todo was successfully destroyed.')
      expect(page).not_to have_content('フロータスク')
    end
  end

  describe 'ルートページ' do
    it 'ルートパスにアクセスするとタスク一覧が表示されること' do
      visit root_path

      expect(page).to have_content('タスク一覧')
    end
  end
end

