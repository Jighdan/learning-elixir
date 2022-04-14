# Identicon

An image generator application that generates an identicon image. Similar to the default identicon generator from GitHub.

These identicon will be composed by `5 * 5` grids of `50px` each, totaling to an square of `250px * 250px`.

Identicon are mirrored from the central `y` axis.

## Process

### Detailed flow

```text
  String ->
    Compute MD5 hash of string ->
      List of numbers based on the string ->
        Pick color ->
          Build grid of squares ->
            Convert grid into image ->
              Save image
```

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `identicon` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:identicon, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/identicon>.
