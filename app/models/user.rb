class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable and :omniauthable
  has_one :request
  devise :database_authenticatable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
end
