class User < ApplicationRecord
  has_secure_password

  validates :email, uniqueness: true, presence: true
  validates :username, uniqueness: true, presence: true
  validate :password_requirements
  validates :role, presence: true
  validate :role_in_list

  def self.get_roles
    @roles = ["admin","moderator"]
end

def self.role
  user.role if user
end


  def self.find_by_email_or_username(data)
    find_by(email: data) || find_by(username: data)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(validate:false)
    UserMailer.password_reset(self).deliver
  end

  def generate_token(column)
    loop do
      token = SecureRandom.urlsafe_base64
      unless User.exists?(column => token)
        self[column] = token
        break
      end
    end
  end


  private
  def password_requirements
    if password.blank?
      errors.add(:password, "can't be blank")
    elsif password.length < 8
      errors.add(:password, "must be at least 8 characters long")
    elsif !password.match?(/[a-zA-Z]/)
      errors.add(:password, "must contain at least one letter")
    elsif !password.match?(/\d/)
      errors.add(:password, "must contain at least one number")
    elsif password.chars.uniq.length == 1
      errors.add(:password, "must contain at least one unique character")
    end
  end

  def role_in_list
    @roles = User.get_roles()
    unless @roles.include?(role)
      errors.add(:role, "not a valid role")
    end
  end
end
