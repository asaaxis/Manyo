class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  enum status: {未着: 0, 着手中: 1, 完了: 2}

  scope :status, -> (status){where(status: status)}
  scope :title, -> (title){where("title LIKE ?", "%#{title}%")}
  scope :title_status, -> (title,status){where("title LIKE ?", "%#{title}%").where(status: status)}
end
