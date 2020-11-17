class BuilderFile < ApplicationRecord
  belongs_to :fileable, polymorphic: true, optional: true
end
