require 'rails_helper'
RSpec.describe 'ラベル管理機能', type: :system do
  let!(:user) { FactoryBot.create(:user) }
  let!(:label) { FactoryBot.create(:label) }
  let!(:task) { FactoryBot.create(:task, title: 'task', content: 'tasks', limit: '2022/12/23', status: '完了', priority: '高',  user: user) }
  describe do
    before do
      visit new_session_path
      fill_in 'session_email', with: 'sample@sample.com'
      fill_in 'session_password', with: '111111'
      click_on 'Log in'
      visit tasks_path
      visit new_task_path
      fill_in 'task_title', with: 'task'
      fill_in 'task_content', with: 'tasks'
      check 'task[label_ids][]'
      click_on '登録'
    end
    describe '新規作成機能' do
      context 'タスクを新規作成した場合' do
        it 'ラベルも一緒に登録できる' do
          expect(page).to have_content 'task'
          expect(page).to have_content 'tasks'
          expect(page).to have_content 'sample1'
        end
        it "ラベル検索でラベルに完全一致するタスクが絞り込まれる" do
          select 'sample1', from: 'task[label_id]'
          click_on 'search'
          expect(page).to have_content 'sample1'
        end
      end
    end
  end
end
# bundle exec rspec spec/system/label_spec.rb