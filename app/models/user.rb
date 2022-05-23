class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable
  has_many :requests
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable

  def full_name
    "#{name} #{surname}"
  end
end
