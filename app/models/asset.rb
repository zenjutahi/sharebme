class Asset < ApplicationRecord
  belongs_to :folder, optional: true
  
  belongs_to :user
  
  # Set up "uploaded_file" field as attached_file (using Paperclip)
  has_attached_file :uploaded_file,
                  path: ":Rails_root/assets/:id/:basename.:extension",
                  storage: :s3,
                  s3_host_name: "sharebme.s3-eu-west-3.amazonaws.com",
                  s3_credentials: {
                    access_key_id: "AKIAXSDKOY47SLUY6Q7O",
                    secret_access_key: "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",
                    s3_region: "eu-west-3",
                    bucket: "sharebme"          
                  }
                  
  
  validates_attachment_size :uploaded_file, :less_than => 10.megabytes
  validates_attachment_presence :uploaded_file
  # validates :record_fingerprint, uniqueness: { message: 'Duplicate document.' }
  
  do_not_validate_attachment_file_type :uploaded_file
  
  def file_name
    uploaded_file_file_name
  end
  
  def file_size
    uploaded_file_file_size
  end
  
end

