ActiveSupport.on_load(:action_text_markdown) do
  require "renderer_with_syntax_highlighting"
  ActionText::Markdown.renderer = RendererWithSyntaxHighlighting.with_defaults
end
