require 'bundler/setup'
require 'trello'

# 1. authorize client
# 2. invoke client with board id
# 3. present list of lists to choose from
# 4. receive choice
# 5. output list as markdown

# could put this module in /ext and require relative
module TrelloCardRefinements
  refine Trello::Card do
    # could add a prefix and suffix here if you wanted to make lists or bold items or whatever
    def as_markdown
      "[#{name}](#{short_url})"
    end
  end
end

class Client
  using TrelloCardRefinements
  attr_accessor :lists, :cards, :board

  def initialize(board_id)
    Dotenv.load
    Trello.configure do |config|
      config.developer_public_key = ENV.fetch('TRELLO_DEVELOPER_PUBLIC_KEY')
      config.member_token = ENV.fetch('TRELLO_MEMBER_TOKEN')
    end
    @board = board_id
  end

  def get_board_lists
    @lists = Trello::Board.find(@board).lists
    @lists.each_with_index do |list, index|
      puts "#{index}. #{list.name} => #{list.id}"
    end
  end

  def list_cards(list_id)
    @cards = Trello::List.find(list_id).cards
  end

  def generate_links
    @cards.each do |card|
      puts card.as_markdown
    end
  end
end
