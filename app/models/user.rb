class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Gender is stored as an integer in DB
  def self.gender_mapping
    {
        0 => "Male",
        1 => "Female"
    }
  end

  # Various age groups
  def self.age_groups
    {
        "< 11" => 1,
        "11-17" => 2,
        "18-24" => 3,
        "25-40" => 4,
        "> 40" => 5
    }
  end

  # List of locations identified by the application
  def self.locations
    %w[
        Bangalore
        Chennai
        Delhi
        Hyderabad
        Jaipur
        Kochi
        Kolkata
        Mumbai
    ]
  end

  # First user in table gets admin privileges
  def admin
    id == User.first.id
  end

end
