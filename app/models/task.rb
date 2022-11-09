class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings

  enum status: {未着: 0, 着手中: 1, 完了: 2}
  enum priority: {高: 0, 中: 1, 低: 2}

  scope :status, -> (status){where(status: status)}
  scope :title, -> (title){where("title LIKE ?", "%#{title}%")}
  scope :title_status, -> (title,status){where("title LIKE ?", "%#{title}%").where(status: status)}
  # scope :label, -> (label){where(label: label)}
end
