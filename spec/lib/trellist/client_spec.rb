require 'spec_helper'
require_relative '../../../lib/trellist/client.rb'

RSpec.describe 'Client' do
  describe 'a new client', record: :skip do
    context 'without the proper arguments' do
      it 'requires a board_id' do
        expect{Client.new(key: 'foo', token: 'foo_token')}.
          to raise_error(ArgumentError)
      end

      it 'requires a key' do
        expect{Client.new(board_id: 'my_board', token: 'foo_token')}.
          to raise_error(ArgumentError)
      end

      it 'requires a token' do
        expect{Client.new(board_id: 'my_board', key: 'foo')}.
          to raise_error(ArgumentError)
      end

      it 'requires arguments' do
        expect{Client.new()}.to raise_error(ArgumentError)
      end
    end

    context 'with all of the proper arguments' do
      it 'does not raise an argument error' do
        expect{Client.new(board_id: 'foo',
                          key: 'blah123blah',
                          token: 'xzypdq')}.not_to raise_error
      end
    end
  end

  describe 'get board lists' do
    it 'sets @client.lists' do
      @client = Client.new(board_id: 't3anNqoJ',
                           token: 'myTRELLOtoken',
                           key: 'myTRELLOkey')
      @client.get_board_lists
      expect(@client.lists).not_to be_nil
      expect(@client.lists.size).to eq(1)
    end
  end

  describe 'get list cards' do
    let(:client) { Client.new(board_id: 't3anNqoJ',
                         token: 'myTRELLOkey',
                         key: 'myTRELLOtoken') }

    context 'witout a label argument' do
      it 'sets @client.cards' do
        client.list_cards('5883d2c40c15260ae897621d')
        expect(client.cards).not_to be_nil
        expect(client.cards.size).to eq(3)
      end
    end

    context 'with a label argument' do
      it 'sets @client.cards limited by card label' do
        client.list_cards('5883d2c40c15260ae897621d', label: 'red')
        expect(client.cards).not_to be_nil
        expect(client.cards.size).to eq(1)
      end
    end
  end

  describe 'generate links' do
    before do
      @client = Client.new(board_id: 'foo',
                           key: 'blah123blah',
                           token: 'xzypdq')
      card = Trello::Card.new(name: 'mock card title')
      @client.cards = [card]
      allow_any_instance_of(Trello::Card).
        to receive(:short_url).and_return('http://example.com/foobar')
    end

    context 'format: markdown' do
      it 'prints link in markdown' do
        expect(@client.generate_links(format: 'markdown').first).
          to eq("[mock card title](http://example.com/foobar)")
      end
    end

    context 'format: plain' do
      it 'prints link plainly' do
        expect(@client.generate_links(format: 'plain').first).
          to eq("http://example.com/foobar")
      end
    end

    context 'format: html' do
      it 'prints link like markdown' do
        expect(@client.generate_links(format: 'html').first).
          to eq("<a href=\"http://example.com/foobar\">mock card title</a>")
      end
    end

    context 'format: markdown, prefix: small trello icon' do
      it 'prints link like markdown' do
        expect(@client.generate_links(prefix: '![](https://github.trello.services/images/mini-trello-icon.png) ').first).
          to eq("![](https://github.trello.services/images/mini-trello-icon.png) [mock card title](http://example.com/foobar)")
      end
    end
  end
end
