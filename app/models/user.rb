class User < ApplicationRecord
  has_many :assets
  has_many :folders
  # this is for folders which this user has shared
  has_many :shared_folders, :dependent => :destroy
  # this is for folders which the user has been shared by other users
  has_many :being_shared_folders, :class_name => "SharedFolder", :foreign_key => "shared_user_id"
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end
