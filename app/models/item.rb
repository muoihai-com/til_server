class Item < ApplicationRecord
  
  enum status: { new: 0, built: 1 }, _suffix: true

  before_update :set_new_status
  after_destroy :remove_output_file

  def set_new_status
    status = :new
  end

  def remove_output_file
    remove_file output
  end

  def output
    "items/#{slug}.html"
  end

  def slug
    title.strip.tr(
      "ÁÀẢẠÃĂẮẰẲẶẴÂẤẦẨẬẪĐÉÈẺẸẼÊẾỀỂỆỄÍÌỈỊĨÓÒỎỌÕÔỐỒỔỘỖƠỚỜỞỢỠÚÙỦỤŨƯỨỪỬỰỮÝỲỶỴỸáàảạãăắằẳặẵâấầẩậẫđéèẻẹẽêếềểệễíìỉịĩóòỏọõôốồổộỗơớờởợỡúùủụũưứừửựữýỳỷỵỹ",
      "AAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYYaaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyy"
    ).parameterize
  end
end
