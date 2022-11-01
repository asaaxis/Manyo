require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', content: 'tasks') }
    FactoryBot.create(:second_task, title: '付け加えた名前', content: '付け加えたコンテント')
  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in "タイトル", with: 'task'
        fill_in "内容", with: 'tasks'
        click_on '登録'
        expect(page).to have_content 'task'
        expect(page).to have_content 'tasks'
      end
    end
  end
  describe '一覧表示機能' do
    before do
      visit tasks_path
    end
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        visit tasks_path
        expect(page).to have_content 'task'
      end
    end
    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task_list = all('td') 
        expect(task_list[0]).to have_content 'task'
      end
    end
    context '終了期限でソートするボタンを押した場合' do
      it '終了期限が遅いタスクが一番上に表示される' do
        task = FactoryBot.create(:task, limit: '2022-11-03')
        click_on "終了期限でソートする"
        task_list = all('tbody')
        expect(task_list[0]).to have_content '2022-11-03'
      end
    end
  end
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        visit task_path(task.id)
        expect(page).to have_content 'task'
      end
    end
  end
end
# bundle exec rspec spec/system/task_spec.rb