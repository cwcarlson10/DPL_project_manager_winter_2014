class User < ActiveRecord::Base
  has_many :tasks
  has_many :projects

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true

  scope :with_github_state, ->(state_param) { where(github_state: state_param).where.not(github_state: nil) }

  def generate_github_state!
    self.update_attributes(github_state: self.generate_github_state)
    self.github_state
  end

  def generate_github_state
    SecureRandom.hex
  end

  def authorized_for_github!(authorized_token)
    self.update_attributes(github_access_token: authorized_token, github_state: 'completed')
  end

  def is_github_authorized?
    self[:github_access_token] && self[:github_state] == 'completed'
  end
end
