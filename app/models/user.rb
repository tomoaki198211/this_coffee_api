# frozen_string_literal: true

class User < ActiveRecord::Base
  before_create :admin_not_create
  before_update :admin_not_update
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable
  include DeviseTokenAuth::Concerns::User

  #adminアカウントが1以上の場合は必ず一般ユーザーになる
  def admin_not_create
    if User.where(admin: true).count >= 1
      self.admin = false
    end
  end

  #adminアカウントが1の場合はupdateでadminを増やす事が出来ない。
  def admin_not_update
    throw(:abort) if User.where(admin: true).count >= 1 && will_save_change_to_attribute?(:admin, to: true)
  end
end
