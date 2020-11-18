class Item < ApplicationRecord
  attr_accessor :attr_tags

  has_many :item_tags, dependent: :destroy
  has_many :tags, through: :item_tags
  has_one :builder_file, as: :fileable

  enum status: { new: 0, built: 1 }, _suffix: true

  default_scope { order created_at: :desc }

  after_save :create_tag
  before_update :set_new_status

  def create_tag
    return if attr_tags.blank?

    item_tags.destroy_all
    existing_tags = Tag.all.to_a
    attr_tags.downcase.split(" ").each do |tag_name|
      tag = existing_tags.find{ |x| x.name.downcase == tag_name }
      tags << tag if tag.present?

      next
    end
  end

  def set_new_status
    self.status = :new
  end

  def output
    "items/#{slug}.html"
  end

  def slug
    create_slug title
  end
end
