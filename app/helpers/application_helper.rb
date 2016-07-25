module ApplicationHelper
  def markdown(content)
    renderer = Redcarpet::Render::HTML
    options = {
      autolink: true,
      strikethrough: true,
      lax_spacing: true,
      superscript: true,
      underline: true,
      highlight: true,
      quote: true,
      footnotes: true,
      no_images: true
    }
    Redcarpet::Markdown.new(renderer, options).render(content).html_safe
  end
end
