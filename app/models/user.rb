Rails.application.config.active_record.belongs_to_required_by_default = false

class User < ApplicationRecord
  has_many :posts
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates_presence_of :first_name, :last_name, :phone

  def full_name
    last_name.upcase + ", " + first_name.upcase    
  end
end
