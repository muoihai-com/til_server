class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  private

  def file_exists? output
    File.exists?(output)
  end

  def remove_file output
    return unless file_exists?(public_path(output))

    FileUtils.rm_f(public_path(output))
  end

  def public_path output
    Rails.root.join("public", output)
  end
end
