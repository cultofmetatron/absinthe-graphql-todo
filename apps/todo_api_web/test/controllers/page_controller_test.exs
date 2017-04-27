defmodule TodoApi.Web.PageControllerTest do
  use TodoApi.Web.ConnCase
  use Hound.Helpers

  hound_session()
  defp login_index do
    Application.get_env(:todo_api_web, TodoApi.Web.Endpoint)[:index]
  end

  setup do
    #hound_session()
    # display its raw source
    IO.inspect(login_index)

    :ok
  end


  test "GET /", %{conn: conn} do
    #conn = get conn, "/"
    #response =  html_response(conn, 200)
    navigate_to("http://localhost:4001/")
    IO.inspect page_source()

  end

  
end
