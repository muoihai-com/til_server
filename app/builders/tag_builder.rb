class TagBuilder < BaseBuilder
  def build_show
    Tag.order(name: :asc).all.each do |tag|
      build path: 'tags/show.html.erb', locals: { tag: tag }, out: tag.output
    end
  end
end
