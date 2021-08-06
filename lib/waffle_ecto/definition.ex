defmodule Waffle.Ecto.Definition do
  @moduledoc """
  Provides a set of functions to ease integration with Waffle and Ecto.

  In particular:

    * Definition of a custom Ecto Type responsible for storing the images
    * URL generation with a cache-busting timestamp query parameter

  ## Example

      defmodule MyApp.Uploaders.AvatarUploader do
        use Waffle.Definition
        use Waffle.Ecto.Definition

        # ...
      end

  ## URL generation

  Both public and signed urls will include the timestamp for cache
  busting, and are retrieved the exact same way as using Waffle
  directly.

      user = Repo.get(User, 1)

      # To receive a single rendition:
      MyApp.Uploaders.AvatarUploader.url({user.avatar, user}, :thumb)
      #=> "https://bucket.s3.amazonaws.com/uploads/avatars/1/thumb.png?v=63601457477"

      # To receive all renditions:
      MyApp.Uploaders.AvatarUploader.urls({user.avatar, user})
      #=> %{original: "https://.../original.png?v=1234", thumb: "https://.../thumb.png?v=1234"}

      # To receive a signed url:
      MyApp.Uploaders.AvatarUploader.url({user.avatar, user}, signed: true)
      MyApp.Uploaders.AvatarUploader.url({user.avatar, user}, :thumb, signed: true)

  """

  defmacro __using__(_options) do
    definition = __CALLER__.module

    quote do
      defmodule Module.concat(unquote(definition), "Type") do
        # After the 3.2 version Ecto has moved @behavior
        # inside the `__using__` macro
        if macro_exported?(Ecto.Type, :__using__, 1) do
          use Ecto.Type
        else
          # in order to support versions lower than 3.2
          @behaviour Ecto.Type
        end

        def type, do: Waffle.Ecto.Type.type()
        def cast(value), do: Waffle.Ecto.Type.cast(unquote(definition), value)
        def load(value), do: Waffle.Ecto.Type.load(unquote(definition), value)
        def dump(value), do: Waffle.Ecto.Type.dump(unquote(definition), value)
      end
    end
  end
end
