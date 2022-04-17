defmodule Cards do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """

  @doc """
    Creates a **deck** of **cards**
  """
  def create_deck do
    values = ["Ace", "2", "3", "4", "5", "6", "7", "8", "9", "10", "J", "Q", "K"]
    suits = ["Spades", "Clubs", "Hearts", "Diamonds"]

    cards =
      for suit <- suits, value <- values do
        "#{value} of #{suit}"
      end

    List.flatten(cards)
  end

  @doc """
    Shuffles a **deck** of **cards**.
  """
  def shuffle(deck) do
    deck |> Enum.shuffle()
  end

  @doc """
    Divide a deck into a hand and the remainder of the deck. Te `hand_size`
    argument indicatess  how many cards should be in hand.

  ## Examples

      iex> deck = Cards.create_deck
      iex> {hand, _new_deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]
    
  """
  def deal(deck, hand_size) do
    deck |> Enum.split(hand_size)
  end

  @doc """
    Determines whether a deck contains a given card.

  ## Examples

      iex> deck = Cards.create_deck
      iex> Cards.contains?(deck, "Ace of Spades")
      true

  """
  def contains?(deck, card) do
    deck |> Enum.member?(card)
  end

  def save(deck, filename) do
    binary = :erlang.term_to_binary(deck)
    File.write(filename, binary)
  end

  def load(filename) do
    case File.read(filename) do
      {:ok, binary} -> binary |> :erlang.binary_to_term()
      {:error, _} -> "File '#{filename}' doesn't exist"
    end
  end

  def create_hand(hand_size) do
    Cards.create_deck() |> Cards.shuffle() |> Cards.deal(hand_size)
  end
end
