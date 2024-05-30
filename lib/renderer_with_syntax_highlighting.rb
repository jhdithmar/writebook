require "rouge/plugins/redcarpet"

class RendererWithSyntaxHighlighting < Redcarpet::Render::HTML
  include Rouge::Plugins::Redcarpet

  def self.with_defaults
    Redcarpet::Markdown.new(
      RendererWithSyntaxHighlighting.new(ActionText::Markdown::DEFAULT_RENDERER_OPTIONS),
      ActionText::Markdown::DEFAULT_MARKDOWN_EXTENSIONS)
  end
end
