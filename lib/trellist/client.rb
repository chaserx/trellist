require 'trello'

# 1. authorize client
# 2. invoke client with board id
# 3. present list of lists to choose from
# 4. receive choice
# 5. output list as markdown (or other format)

# could put this module in trellist/ext and require relative
module TrelloCardRefinements
  refine Trello::Card do
    def as_markdown(prefix: '', suffix: '')
      "#{prefix}[#{name}](#{short_url})#{suffix}"
    end

    def as_html(prefix: '', suffix: '')
      "#{prefix}<a href=\"#{short_url}\">#{name}</a>#{suffix}"
    end
  end
end

class Client
  using TrelloCardRefinements
  attr_accessor :lists, :cards, :board

  def initialize(board_id:, key:, token:)
    @board = board_id
    @key = key
    @token = token

    Trello.configure do |config|
      config.developer_public_key = key
      config.member_token = token
    end
  end

  def get_board_lists
    @lists = Trello::Board.find(@board).lists
  end

  def list_cards(list_id, label: nil)
    @cards = Trello::List.find(list_id).cards
    if label
      @cards.select! {|card| card.labels.map(&:name).include?(label) }
    end
  end

  def generate_links(format: 'markdown', prefix: '', suffix: '')
    @cards.each do |card|
      case format
      when 'markdown'
        puts card.as_markdown(prefix: prefix, suffix: suffix)
      when 'plain'
        puts card.short_url
      when 'html'
        puts card.as_html(prefix: prefix, suffix: suffix)
      else
        puts card.inspect
      end
    end
  end
end
