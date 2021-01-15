class User < ActiveRecord::Base
  has_secure_password

  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, confirmation: true, length: { minimum: 4 }
  validates :password_confirmation, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  before_save :validate_email

  def validate_email
    self.email = email.strip
    email.downcase!
  end

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.strip)
    return @user if @user && @user.authenticate(password) else nil
  end
end
