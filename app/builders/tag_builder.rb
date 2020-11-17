class TagBuilder < BaseBuilder
  def build_show
    Tag.order(name: :asc).all.each do |tag|
      build path: 'tags/show.html.erb', locals: { tag: tag }, out: tag.output
      BuilderFile.find_or_create_by fileable_type: Tag.name, fileable_id: tag.id, output: tag.output
    end
  end
end
