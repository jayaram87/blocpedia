class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :wikis
  enum role: [:standard, :premium, :admin]
  after_initialize :set_default_role
  
  private
  def set_default_role
    self.role ||= :standard  
  end
end
