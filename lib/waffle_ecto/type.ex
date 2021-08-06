defmodule Waffle.Ecto.Type do
  @moduledoc """
  Provides implementation for custom Ecto.Type behaviour.
  """

  require Logger

  def type, do: :string

  def cast(definition, args) do
    case definition.store(args) do
      {:ok, file} ->
        {:ok, file}

      error ->
        Logger.error(inspect(error))
        :error
    end
  end

  def load(_definition, value) do
    {:ok, value}
  end

  def dump(_definition, value) do
    {:ok, value}
  end
end
