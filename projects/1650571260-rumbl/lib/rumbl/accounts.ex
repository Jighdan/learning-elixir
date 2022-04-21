defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts context
  """

  alias Rumbl.Accounts.User

  def list_users do
    [
      %User{id: "1", name: "Tino", username: "tinoposh"},
      %User{id: "2", name: "Paola", username: "lamadura"},
      %User{id: "3", name: "Justyna", username: "callicore"}
    ]
  end

  def get_user(id) do
    Rumbl.Accounts.list_users() |> Enum.find(&(&1.id == id))
  end

  def get_user_by(params) do
    Enum.find(Rumbl.Accounts.list_users(), fn map ->
      Enum.all?(params, fn {key, val} -> Map.get(map, key) == val end)
    end)
  end
end
