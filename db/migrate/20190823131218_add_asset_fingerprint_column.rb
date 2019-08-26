class AddAssetFingerprintColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :assets, :uploaded_file_fingerprint, :string
  end
end
