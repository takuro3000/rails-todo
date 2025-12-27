require 'rails_helper'

RSpec.describe 'Todos', type: :request do
  let(:valid_attributes) do
    { title: 'テストタスク', description: 'これはテストです', completed: false }
  end

  let(:invalid_attributes) do
    { title: '', description: 'タイトルなし', completed: false }
  end

  describe 'GET /todos' do
    it '正常にレスポンスを返すこと' do
      get todos_path
      expect(response).to have_http_status(:ok)
    end

    it '一覧ページを表示すること' do
      Todo.create!(valid_attributes)
      get todos_path
      expect(response.body).to include('タスク一覧')
    end

    context 'Todoが存在する場合' do
      it 'Todoのタイトルが表示されること' do
        todo = Todo.create!(valid_attributes)
        get todos_path
        expect(response.body).to include(todo.title)
      end
    end

    context 'Todoが存在しない場合' do
      it '空の状態メッセージが表示されること' do
        get todos_path
        expect(response.body).to include('タスクがありません')
      end
    end
  end

  describe 'GET /todos/:id' do
    let!(:todo) { Todo.create!(valid_attributes) }

    it '正常にレスポンスを返すこと' do
      get todo_path(todo)
      expect(response).to have_http_status(:ok)
    end

    it 'Todoの詳細が表示されること' do
      get todo_path(todo)
      expect(response.body).to include(todo.title)
      expect(response.body).to include(todo.description)
    end
  end

  describe 'GET /todos/new' do
    it '正常にレスポンスを返すこと' do
      get new_todo_path
      expect(response).to have_http_status(:ok)
    end

    it '新規作成フォームが表示されること' do
      get new_todo_path
      expect(response.body).to include('タスクを作成')
    end
  end

  describe 'GET /todos/:id/edit' do
    let!(:todo) { Todo.create!(valid_attributes) }

    it '正常にレスポンスを返すこと' do
      get edit_todo_path(todo)
      expect(response).to have_http_status(:ok)
    end

    it '編集フォームが表示されること' do
      get edit_todo_path(todo)
      expect(response.body).to include('タスクを更新')
    end
  end

  describe 'POST /todos' do
    context '有効なパラメータの場合' do
      it 'Todoが作成されること' do
        expect {
          post todos_path, params: { todo: valid_attributes }
        }.to change(Todo, :count).by(1)
      end

      it '作成後にリダイレクトされること' do
        post todos_path, params: { todo: valid_attributes }
        expect(response).to redirect_to(Todo.last)
      end

      it '成功メッセージが設定されること' do
        post todos_path, params: { todo: valid_attributes }
        follow_redirect!
        expect(response.body).to include('Todo was successfully created.')
      end
    end

    context '無効なパラメータの場合' do
      it 'Todoが作成されないこと' do
        expect {
          post todos_path, params: { todo: invalid_attributes }
        }.not_to change(Todo, :count)
      end

      it 'unprocessable_entityを返すこと' do
        post todos_path, params: { todo: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'エラーメッセージが表示されること' do
        post todos_path, params: { todo: invalid_attributes }
        expect(response.body).to include('エラーがあります')
      end
    end
  end

  describe 'PATCH /todos/:id' do
    let!(:todo) { Todo.create!(valid_attributes) }

    context '有効なパラメータの場合' do
      let(:new_attributes) { { title: '更新されたタスク', completed: true } }

      it 'Todoが更新されること' do
        patch todo_path(todo), params: { todo: new_attributes }
        todo.reload
        expect(todo.title).to eq('更新されたタスク')
        expect(todo.completed).to eq(true)
      end

      it '更新後にリダイレクトされること' do
        patch todo_path(todo), params: { todo: new_attributes }
        expect(response).to redirect_to(todo)
      end

      it '成功メッセージが設定されること' do
        patch todo_path(todo), params: { todo: new_attributes }
        follow_redirect!
        expect(response.body).to include('Todo was successfully updated.')
      end
    end

    context '無効なパラメータの場合' do
      it 'Todoが更新されないこと' do
        patch todo_path(todo), params: { todo: invalid_attributes }
        todo.reload
        expect(todo.title).to eq('テストタスク')
      end

      it 'unprocessable_entityを返すこと' do
        patch todo_path(todo), params: { todo: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /todos/:id' do
    let!(:todo) { Todo.create!(valid_attributes) }

    it 'Todoが削除されること' do
      expect {
        delete todo_path(todo)
      }.to change(Todo, :count).by(-1)
    end

    it '削除後に一覧にリダイレクトされること' do
      delete todo_path(todo)
      expect(response).to redirect_to(todos_path)
    end

    it '成功メッセージが設定されること' do
      delete todo_path(todo)
      follow_redirect!
      expect(response.body).to include('Todo was successfully destroyed.')
    end
  end

  describe 'GET /' do
    it 'ルートパスがtodos#indexにルーティングされること' do
      get root_path
      expect(response).to have_http_status(:ok)
      expect(response.body).to include('タスク一覧')
    end
  end
end

