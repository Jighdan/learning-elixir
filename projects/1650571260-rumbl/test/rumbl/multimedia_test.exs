defmodule Rumbl.MultimediaTest do
  use Rumbl.DataCase, async: true

  alias Rumbl.Multimedia
  alias Rumbl.Multimedia.Video
  alias Rumbl.Multimedia.Category

  describe "videos" do
    @valid_attrs %{description: "desc", title: "title", url: "http://local"}

    test "list_videos/0 returns all videos" do
      owner = user_fixture()
      %Video{id: id1} = video_fixture(owner)
      assert [%Video{id: ^id1}] = Multimedia.list_videos()

      %Video{id: id2} = video_fixture(owner)
      assert [%Video{id: ^id1}, %Video{id: ^id2}] = Multimedia.list_videos()
    end

    test "get_video!/1 returns the video with the given id" do
      owner = user_fixture()
      %Video{id: id} = video_fixture(owner)
      assert %Video{id: ^id} = Multimedia.get_video!(id)
    end

    test "create_video/2 with valid data creates a video" do
      owner = user_fixture()
      assert {:ok, %Video{} = _video} = Multimedia.create_video(owner, @valid_attrs)
    end
  end

  describe "categories" do
    test "list_categories_alphabetically/0" do
      for name <- ~w(Drama Action Comedy) do
        Multimedia.create_category!(name)
      end

      alpha_names =
        for %Category{name: name} <-
              Multimedia.list_categories_alphabetically() do
          name
        end

      assert alpha_names == ~w(Action Comedy Drama)
    end
  end
end
