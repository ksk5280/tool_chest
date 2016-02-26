class User < ActiveRecord::Base
  has_secure_password
  has_many :tools

  validates :username, presence: true, uniqueness: true

  enum role: %w(default admin)

  def dashboard_path
    if self.admin?
      "/admin/#{id}"
    else
      "/users/#{id}"
    end
  end
end
