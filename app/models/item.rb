class Item < ApplicationRecord

  def segment
    title.strip.gsub(" ", "-")
  end
end
