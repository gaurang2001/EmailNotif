class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.gender_mapping
    {
        0 => "Male",
        1 => "Female"
    }
  end

  def admin
    id == User.first.id
  end
end
