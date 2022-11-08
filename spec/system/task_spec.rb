require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:task) { FactoryBot.create(:task, user: user,  title: 'task', content: 'tasks', limit: '2022/12/23', status: '完了', priority: '高') }
  describe do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'sample@sample.com'
      fill_in 'session_password', with: '111111'
      click_on 'Log in'
    end
    describe '新規作成機能' do
      context 'タスクを新規作成した場合' do
        it '作成したタスクが表示される' do
          visit new_task_path
          fill_in 'task_title', with: 'task'
          fill_in 'task_content', with: 'tasks'
          click_on '登録'
          expect(page).to have_content 'task'
          expect(page).to have_content 'tasks'
          expect(page).to have_content '2022-12-23'
          expect(page).to have_content '完了'
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
          visit tasks_path
          FactoryBot.create(:task, limit: '2022-12-31', user: user)
          click_button "終了期限でソートする"
          sleep(0.5)
          task_list = all('tbody')
          expect(task_list[0]).to have_content '2022-12-31'
        end
      end
      context '優先順位でソートするボタンを押した場合' do
        it '優先順位が高いタスクが一番上に表示される' do
          visit tasks_path
          click_button "優先順位でソートする"
          sleep(0.5)
          task_list = all('tbody')
          expect(task_list[0]).to have_content '高'
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
    describe '検索機能' do
      before do
        FactoryBot.create(:task, title: "task", user: user)
        FactoryBot.create(:second_task, title: "sample", user: user)
      end

      context 'タイトルであいまい検索をした場合' do
        it "検索キーワードを含むタスクで絞り込まれる" do
          visit tasks_path
          fill_in 'task_title', with: 'task'
          click_on 'search'
          expect(page).to have_content 'task'
        end
      end
      context 'ステータス検索をした場合' do
        it "ステータスに完全一致するタスクが絞り込まれる" do
          visit tasks_path
          select '完了', from: 'task[status]'
          click_on 'search'
          expect(page).to have_content '完了'
        end
      end
      context 'タイトルのあいまい検索とステータス検索をした場合' do
        it "検索キーワードをタイトルに含み、かつステータスに完全一致するタスク絞り込まれる" do
          visit tasks_path
          select '完了', from: 'task[status]'
          fill_in 'task_title', with: 'task'
          click_on 'search'
          expect(page).to have_content '完了'
          expect(page).to have_content 'task'
        end
      end
    end
  end
end
# bundle exec rspec spec/system/task_spec.rb