defmodule TodoApi.Web.JwtManager do
  import Plug.Conn 
  alias TodoApi.Repo
  alias TodoApi.Schema.User
  import Joken

  def init(opts), do: opts

  
  def call(conn, _) do
    IO.inspect("jwt manager")
    token = get_token(conn)
    if token do
      case verify_jwt(token) do
        %Joken.Token{error: nil, claims: claims }=payload  ->
          conn |> get_user(Map.get(claims, "user_id"))
        %Joken.Token{error: error, claims: claims } ->
          conn |> put_invalid_token()
      end
    else
      conn |> put_private(:absinthe, %{context: %{ login_status: :unauthenticated }})
    end
  end

  def put_invalid_token(conn) do
    # we can't respond with a graphql response at this level so mark it so it can be passed into
    # a resolver'
    conn |> put_private(:absinthe, %{context: %{ login_status: :invalid_token }})
  end

  def get_user(conn, user_id) do
    IO.inspect(conn)
    IO.puts(user_id)
    case Repo.get(User, user_id) do
      nil -> put_invalid_token(conn)
      user ->
        IO.puts("HELLOOOOOOOOO NURSE")
        put_private(conn, :absinthe, %{context: %{
            login_status: :logged_in,
            current_user: user
          }
        })
    end
  end

  def get_token(conn) do
    bearer_token = get_req_header(conn, "authorization")
    case bearer_token do
      ["Bearer " <> token] -> token
      _ -> nil
    end
  end
  #eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyX2lkIjoiMDkyMDQwYWYtZWJhOC00NjU2LWI0MzgtMjhjNDE5NDhhYTU5IiwiYXVkIjoxMjM0NTY3ODl9.AlOtlkYfKehXqOmtx9OppFnDc2vg-trdIcpw1QM7js8
  def verify_jwt(jwt) do
    secret = Application.get_env(:todo_api_web, :joken)[:secret]
    iss = Application.get_env(:todo_api_web, :joken)[:issuer]
    jwt
      |> token()
      |> with_json_module(Poison)
      |> Joken.with_signer(hs256(secret))
      |> Joken.with_aud(iss)
      |> verify()
  end

  defp base_url do
    return Application.get_env(:todo_api_web, TodoApi.Web.Endpoint)[:url][:host]
  end

  def sign_jwt(%User{}=user) do
    secret = Application.get_env(:todo_api_web, :joken)[:secret]
    iss = Application.get_env(:todo_api_web, :joken)[:issuer]
    %{user_id: user.id}
      |> token()
      |> Joken.with_signer(hs256(secret))
      |> Joken.with_aud(iss)
      |> sign()
      |> get_compact()
  end

  def verify_function() do
    secret = Application.get_env(:todo_api_web, :joken)[:secret]
    iss = Application.get_env(:todo_api_web, :joken)[:issuer]
    %Joken.Token{}
    |> with_json_module(Poison)
    |> Joken.with_signer(hs256(secret))
    |> Joken.with_aud(iss)
  end

end