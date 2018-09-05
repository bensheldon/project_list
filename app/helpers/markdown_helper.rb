# http://stackoverflow.com/a/30468100/241735
class Kramdown::Parser::InlineKramdown < Kramdown::Parser::Kramdown
  def initialize(source, options)
    super
    @block_parsers = []
  end
end

# http://stackoverflow.com/questions/30018652/slim-template-doesnt-render-markdown-stored-in-a-variable/30262589#30262589
module MarkdownHelper
  def markdown(text, options = {})
    options = options.reverse_merge auto_ids: false
    Kramdown::Document.new(text, options).to_html.html_safe
  end

  def inline_markdown(text, options = {})
    options = options.reverse_merge(
      auto_ids: false,
      input: 'InlineKramdown'
    )
    Kramdown::Document.new(text, options).to_html.html_safe
  end
end
