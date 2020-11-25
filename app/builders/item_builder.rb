class ItemBuilder < BaseBuilder
  def build_index
    build path: 'items/index.html.erb', out: 'index.html'
    BuilderFile.find_or_create_by fileable_type: 'Other', output: 'index.html'
  end

  def build_show
    Item.all.each do |item|
      @title = item.title
      build path: 'items/show.html.erb', locals: { item: item }, out: item.output
      item.built_status!
      BuilderFile.find_or_create_by fileable_type: Item.name, fileable_id: item.id, output: item.output
    end
  end
end
