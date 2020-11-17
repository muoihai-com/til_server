class Tag < ApplicationRecord
  has_many :item_tags, dependent: :destroy
  has_many :items, through: :item_tags
  has_one :builder_file, as: :fileable

  def output
    "tags/#{slug}.html"
  end

  def slug
    create_slug name
  end
end
