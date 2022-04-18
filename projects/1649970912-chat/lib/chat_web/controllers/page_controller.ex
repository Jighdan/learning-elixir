defmodule ChatWeb.PageController do
  use ChatWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, _params) do
    render(conn, "log-in.html")
  end

  def sign_up(conn, _params) do
    render(conn, "sign-up.html")
  end
end
