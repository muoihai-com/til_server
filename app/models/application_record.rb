class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true
  after_destroy :remove_output_file

  private

  def output; end

  def create_slug text
    text.strip.tr(
      "ÁÀẢẠÃĂẮẰẲẶẴÂẤẦẨẬẪĐÉÈẺẸẼÊẾỀỂỆỄÍÌỈỊĨÓÒỎỌÕÔỐỒỔỘỖƠỚỜỞỢỠÚÙỦỤŨƯỨỪỬỰỮÝỲỶỴỸáàảạãăắằẳặẵâấầẩậẫđéèẻẹẽêếềểệễíìỉịĩóòỏọõôốồổộỗơớờởợỡúùủụũưứừửựữýỳỷỵỹ",
      "AAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYaaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyy"
    ).parameterize
  end

  def remove_output_file
    return if output.blank?

    remove_file output
  end

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
