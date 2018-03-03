require 'trello'

# 1. authorize client
# 2. invoke client with board id
# 3. present list of lists to choose from
# 4. receive choice
# 5. output list as markdown (or other format)

# NOTE(chaserx): could put this module in trellist/ext and require relative
module TrelloCardRefinements
  refine Trello::Card do
    def as_markdown(prefix: '', suffix: '')
      "#{prefix}[#{name}](#{short_url})#{suffix}"
    end

    def as_html(prefix: '', suffix: '')
      "#{prefix}<a href=\"#{short_url}\">#{name}</a>#{suffix}"
    end

    def as_plain_title(prefix: '', suffix: '')
      "#{prefix}#{name}#{suffix}"
    end

    def as_deckset_markdown
      # NOTE(chaserx): I don't like this although functional. Maybe use erb?
      "\n# #{name}\n" + # slide title; required to start slide
      "\n#{desc}\n" + # slide body
      "\n[#{short_url}](#{short_url})\n" + # link back to card
      "\n#{formatted_attachments.join("\n")}\n" + # list of card attachements
      "\n---\n" # required to end slide
    end

    def formatted_attachments
      attachments.map { |attachment| "\n[#{attachment.name}](#{attachment.url})\n" }
    end
  end
end

class Client
  using TrelloCardRefinements
  attr_accessor :labels, :lists, :cards, :board

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

  def board_labels
    @labels = Trello::Board.find(@board).labels
  end

  def list_cards(list_id, label: nil)
    @cards = Trello::List.find(list_id).cards
    @cards.select! { |card| card.labels.map(&:name).include?(label) } if label
  end

  def generate_links(format: 'markdown', prefix: '', suffix: '')
    case format
    when 'markdown'
      @cards.map { |card| card.as_markdown(prefix: prefix, suffix: suffix) }
    when 'plain'
      @cards.map(&:short_url)
    when 'html'
      @cards.map { |card| card.as_html(prefix: prefix, suffix: suffix) }
    when 'titles-only'
      @cards.map { |card| card.as_plain_title(prefix: prefix, suffix: suffix) }
    when 'slides'
      @cards.map { |card| card.as_deckset_markdown }
    else
      @cards.map(&:inspect)
    end
  end
end
