require 'feedzirra'
require 'ostruct'

# From http://api.rubyonrails.org/classes/ActiveSupport/CoreExtensions/Hash/Keys.html
class Hash
  def stringify_keys!
    keys.each do |key|
      self[key.to_s] = delete(key)
    end
    self
  end
end

class EvernoteRSS
  class << self
    def fetch_feed(username, notebook, count = 10)
      url = "https://www.evernote.com/pub/#{username}/#{notebook}/feed"
      feed = Feedzirra::Feed.fetch_and_parse(url)

      entries = []

      feed.entries.take(count.to_i).each do |i|
        item = OpenStruct.new
        item.title = i.title
        item.url = i.url
        item.published = i.published
        item.summary = i.summary

        entries << item
      end
      entries
    end
  end
end

module Jekyll
  class EvernoteRSSFeedTag < Liquid::Block

    include Liquid::StandardFilters
    Syntax = /(#{Liquid::QuotedFragment}+)?/

    def initialize(tag_name, markup, tokens)
      @variable_name = 'item'
      @attributes = {}

      if markup =~ Syntax
        markup.scan(Liquid::TagAttributes) do |key, value|
          @attributes[key] = value
        end
      else
        raise SyntaxError.new("You've got a syntax error in 'jekyll-evernote_rss'.\nThis is how we do it: evernote_rss username:USERNAME notebook:NAME_OF_NOTEBOOK [count:INT]")
      end

      @username = @attributes['username']
      @notebook = @attributes['notebook']
      @count = @attributes['count']

      @name = 'item'

      super
    end

    def render(context)
      context.registers[:evernote_rss] ||= Hash.new(0)

      collection = EvernoteRSS.fetch_feed(@username, @notebook, @count)
      length = collection.length
      result = []

      context.stack do
        collection.each_with_index do |item, index|
          attrs = item.send('table')
          context[@variable_name] = attrs.stringify_keys! if attrs.size > 0
          context['forloop'] = {
            'name' => @name,
            'length' => length,
            'index' => index + 1,
            'index0' => index,
            'rindex' => length - index,
            'rindex0' => length - index -1,
            'first' => (index == 0),
            'last' => (index == length - 1) }

          result << render_all(@nodelist, context)
        end
      end
      result
    end
  end
end

Liquid::Template.register_tag('evernote_rss', Jekyll::EvernoteRSSFeedTag)
