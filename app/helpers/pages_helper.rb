module PagesHelper
  def render_markdown(source)
    Redcarpet::Markdown.new(Redcarpet::Render::HTML).render(source).html_safe
  end

  def word_count(content)
    pluralize content.split.size, "word"
  end
end
