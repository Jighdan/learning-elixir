defmodule CardsTest do
  use ExUnit.Case
  doctest Cards

  test "Cards.create_deck makes 52 cards" do
    expected_deck_length = 52
    deck_length = length(Cards.create_deck())
    assert expected_deck_length == deck_length
  end

  test "Cards.shuffle randomizes it" do
    deck = Cards.create_deck()
    refute deck == Cards.shuffle(deck)
  end

  test "Cards.deal deals the right number of cards" do
    hand_size = 2
    deck = Cards.create_deck()
    {hand, _new_deck} = Cards.deal(deck, hand_size)
    assert length(hand) == hand_size
  end

  test "Cards.deal remove the dealt cards from the deck" do
    hand_size = 2
    deck = Cards.create_deck()
    {_hand, new_deck} = Cards.deal(deck, hand_size)
    assert length(new_deck) == length(deck) - hand_size
  end

  test "Card.contains? validates whether a card exists" do
    deck = Cards.create_deck()
    assert Cards.contains?(deck, "Ace of Spades") == true
  end

  test "Card.contains? validates whether a card doesn't exists" do
    deck = Cards.create_deck()
    assert Cards.contains?(deck, "Ace of nothing") == false
  end
end
