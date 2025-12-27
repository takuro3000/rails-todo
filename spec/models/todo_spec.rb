require 'rails_helper'

RSpec.describe Todo, type: :model do
  describe 'バリデーション' do
    context 'titleが存在する場合' do
      it '有効であること' do
        todo = Todo.new(title: 'テストタスク')
        expect(todo).to be_valid
      end
    end

    context 'titleが空の場合' do
      it '無効であること' do
        todo = Todo.new(title: '')
        expect(todo).not_to be_valid
      end

      it 'エラーメッセージが含まれること' do
        todo = Todo.new(title: '')
        todo.valid?
        expect(todo.errors[:title]).to include("can't be blank")
      end
    end

    context 'titleがnilの場合' do
      it '無効であること' do
        todo = Todo.new(title: nil)
        expect(todo).not_to be_valid
      end
    end
  end

  describe 'デフォルト値' do
    context '新規レコードを作成した場合' do
      it 'completedがfalseに設定されること' do
        todo = Todo.new(title: 'テストタスク')
        expect(todo.completed).to eq(false)
      end
    end

    context 'completedを明示的に指定した場合' do
      it '指定した値が設定されること' do
        todo = Todo.new(title: 'テストタスク', completed: true)
        expect(todo.completed).to eq(true)
      end
    end
  end

  describe '保存' do
    context '有効な属性の場合' do
      it 'データベースに保存できること' do
        todo = Todo.new(title: 'テストタスク', description: 'これはテストです')
        expect { todo.save }.to change(Todo, :count).by(1)
      end
    end

    context '無効な属性の場合' do
      it 'データベースに保存できないこと' do
        todo = Todo.new(title: '')
        expect { todo.save }.not_to change(Todo, :count)
      end
    end
  end

  describe '属性' do
    it 'title, description, completedを持つこと' do
      todo = Todo.new(
        title: 'テストタスク',
        description: 'これはテストの説明です',
        completed: false
      )
      expect(todo.title).to eq('テストタスク')
      expect(todo.description).to eq('これはテストの説明です')
      expect(todo.completed).to eq(false)
    end
  end
end

