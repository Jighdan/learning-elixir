defmodule Rumbl.Accounts do
  @moduledoc """
  The Accounts context
  """

  alias Rumbl.Repo
  alias Rumbl.Accounts.User

  def get_all(), do: Repo.all(User)

  def get_by_id(id), do: Repo.get(User, id)
  def get_by_id!(id), do: Repo.get!(User, id)

  def get_by(params), do: Repo.get_by(User, params)

  def change(%User{} = user), do: User.changeset(user, %{})

  def create(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end
end
