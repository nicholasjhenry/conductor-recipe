defmodule ConductorRecipeWeb.PageController do
  use ConductorRecipeWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
