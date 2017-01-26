require 'trello'

# 1. authorize client
# 2. invoke client with board id
# 3. present list of lists to choose from
# 4. receive choice
# 5. output list as markdown

# could put this module in /ext and require relative
module TrelloCardRefinements
  refine Trello::Card do
    # Note(chaserx): we could add a prefix and suffix here
    # if the user wanted to make lists or bold items or whatever
    #
    def as_markdown
      "[#{name}](#{short_url})"
    end

    def as_html
      "<a href=\"#{short_url}\">#{name}</a>"
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

  def list_cards(list_id)
    @cards = Trello::List.find(list_id).cards
  end

  def generate_links(format: 'markdown')
    @cards.each do |card|
      case format
      when 'markdown'
        puts card.as_markdown
      when 'plain'
        puts card.short_url
      when 'html'
        puts card.as_html
      else
        puts card.inspect
      end
    end
  end
end
