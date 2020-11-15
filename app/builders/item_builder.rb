class ItemBuilder < BaseBuilder
  def build_index
    build path: 'items/index.html.erb', out: 'index.html'
  end

  def build_show
    Item.all.each do |item|
      build path: 'items/show.html.erb', locals: { item: item }, out: item.output
      item.built_status!
    end
  end
end
