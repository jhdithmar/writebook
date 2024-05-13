class Page < ApplicationRecord
  include Leafable

  attribute :title, default: "Untitled"
  has_markdown :body
end
