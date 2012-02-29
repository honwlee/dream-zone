class User
  include Mongoid::Document
  include Mongoid::Timestamps
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessible :password, :password_confirmation

  field :username

  validates_presence_of :username
  validates_uniqueness_of :username
  #validates_format_of :username, :with => /\A[A-Za-z0-9_.]+\z/
  validates_length_of :username, :maximum => 32
end
