class Folder < ApplicationRecord
  acts_as_tree
  
  
  belongs_to :user
  
  has_many :assets, :dependent => :destroy
  has_many :shared_folders, :dependent => :destroy
  
  def shared?
    !self.shared_folders.empty?
  end
end
