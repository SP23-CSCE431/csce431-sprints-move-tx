class Excuse < ApplicationRecord
  has_one_attached :file

  validate :file_size, if: :file_attached?
  validate :file_type, if: :file_attached?

  private

  def file_size
    if file.blob.byte_size > 5.megabytes
      errors.add(:file, 'File size is too large (Size > 5MB)')
    end
  end

  def file_type
    if !file.blob.content_type.starts_with?('application/pdf')
      errors.add(:file, 'File must be a PDF')
    end
  end

  def file_attached?
    file.attached?
  end

end