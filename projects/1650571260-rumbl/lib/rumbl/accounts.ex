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

  def change_registration(%User{} = user, params) do
    User.registration_changeset(user, params)
  end

  def register_user(attrs \\ %{}) do
    %User{} |> User.registration_changeset(attrs) |> Repo.insert()
  end

  def authenticate_by_username_and_pass(username, given_pass) do
    user = Rumbl.Accounts.get_by(username: username)

    cond do
      user && Pbkdf2.verify_pass(given_pass, user.password_hash) ->
        {:ok, user}

      user ->
        {:error, :unauthorized}

      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
