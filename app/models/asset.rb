class Asset < ApplicationRecord
  
  belongs_to :user
  
  # Set up "uploaded_file" field as attached_file (using Paperclip)
  has_attached_file :uploaded_file
  
  validates_attachment_size :uploaded_file, :less_than => 10.megabytes
  validates_attachment_presence :uploaded_file
  # validates :record_fingerprint, uniqueness: { message: 'Duplicate document.' }
  
  do_not_validate_attachment_file_type :uploaded_file
  
  def file_name
    uploaded_file_file_name
  end
  
end

