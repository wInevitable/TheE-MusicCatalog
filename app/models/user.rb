class User < ActiveRecord::Base
  
  attr_reader :password
  
  validates :email, :token, { :uniqueness => true }
  validates :email, :token, :password_digest, { :presence => true }
  validates :password, :length => { :minimum => 6, :allow_nil => true }
    
  before_validation :ensure_session_token
  
  #has_many comments
  
  def password=(secret)
    if secret.present?
      @password = secret
      self.password_digest = BCrypt::Password.create(secret)
    end
  end
  
  def is_password?(secret)
    BCrypt::Password.new(self.password_digest).is_password?(secret)
  end
  
  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end
  
  def reset_session_token!
    self.token = self.class.generate_session_token
    self.save!
    self.token
  end
  
  def self.find_by_credentials(email, secret)
    @user = User.find_by_email(email)
    @user.try(:is_password?, secret) ? @user : nil
  end
  
  private
  
  def ensure_session_token
    self.token ||= self.class.generate_session_token
  end
end
