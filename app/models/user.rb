class User < ApplicationRecord
  before_destroy :destroy_action
  before_update :update_action

  validates :name,  presence: true, length: { maximum: 30 }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  before_validation { email.downcase! }
  has_secure_password
  validates :password, length: { minimum: 6 }

  has_many :tasks, dependent: :destroy

  private

  def destroy_action
    if User.where(admin:true).count == 1 && self.admin
      throw :abort
    end
  end

  def update_action
    @admin_users = User.where(admin: true)
      if(@admin_users.count == 1 && @admin_users.first == self) && self.admin == false
        errors.add :base, "管理者がいなくなります"
        throw :abort
      end
  end
end
