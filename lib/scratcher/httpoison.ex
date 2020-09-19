defmodule Scratcher.HTTPoison do
  @moduledoc """
  It is a module for using HTTPoison in the interface of [Scratcher.HttpClient](https://github.com/ritou/elixir-scratcher/blob/master/lib/scratcher/http_client.ex).
  """

  @behaviour Scratcher.HttpClient

  @doc """
  As described in [Scratcher.HttpClient](https://github.com/ritou/elixir-scratcher), you can use it equivalently to other HTTP Clients.

  ```elixir
  config :your_module, http_client: Scratcher.HTTPoison
  ```

  ```elixir
  defmodule YourModule do
    @http_client Application.fetch_env!(:your_module) |> Keyword.fetch!(:http_client)

    def request(method, url, body, headers, http_opts) do
      @http_client.request(method, url, body, headers, http_opts)
    end
  end
  ```

  """
  def request(method, url, body \\ "", headers \\ [], http_opts \\ [])

  # https://hexdocs.pm/httpoison/HTTPoison.html#get/3
  def request(:get, url, _body, headers, http_opts),
    do: HTTPoison.get(url, headers, http_opts) |> parse_response()

  # https://hexdocs.pm/httpoison/HTTPoison.html#post/4
  def request(:post, url, body, headers, http_opts),
    do: HTTPoison.post(url, body, headers, http_opts) |> parse_response()

  # https://hexdocs.pm/httpoison/HTTPoison.html#put/4
  def request(:put, url, body, headers, http_opts),
    do: HTTPoison.put(url, body, headers, http_opts) |> parse_response()

  # https://hexdocs.pm/httpoison/HTTPoison.html#delete/3
  def request(:delete, url, _body, headers, http_opts),
    do: HTTPoison.delete(url, headers, http_opts) |> parse_response()

  defp parse_response(
         {:ok, %HTTPoison.Response{status_code: status_code, headers: headers, body: body}}
       ),
       do: {:ok, %{status_code: status_code, headers: headers, body: body}}

  defp parse_response({:error, %HTTPoison.Error{reason: reason}}), do: {:error, %{reason: reason}}
  defp parse_response(error), do: {:error, %{reason: nil}}
end
