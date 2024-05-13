module ActionText
  class Markdown < Record
    belongs_to :record, polymorphic: true, touch: true
    has_many_attached :uploads, dependent: :destroy

    def to_html
      markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
      markdown.render(content).html_safe
    end
  end
end
