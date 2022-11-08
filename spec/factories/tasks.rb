FactoryBot.define do
  # let!(:user) { FactoryBot.create(:user) }
  # let!(:task) { FactoryBot.create(:task, user: user) }
  factory :task do
    title { 'Factoryで作ったデフォルトのタイトル1' }
    content { 'Factoryで作ったデフォルトのコンテント1' }
    limit { 'Date.time' }
    status { '未着' }
    priority { '中' }
  end
  factory :second_task, class: Task do
    title { 'Factoryで作ったデフォルトのタイトル2' }
    content { 'Factoryで作ったデフォルトのコンテント2' }
    limit { 'Date.time' }
    status { '未着' }
    priority { '中' }
  end
end