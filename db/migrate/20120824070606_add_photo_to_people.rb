class AddPhotoToPeople < ActiveRecord::Migration
  def change
      add_column :people, :photo_file_name, :string # Original filename
      add_column :people, :photo_content_type, :string # Mime type
      add_column :people, :photo_file_size, :integer # File size in bytes
    end
end
