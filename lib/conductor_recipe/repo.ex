defmodule ConductorRecipe.Repo do
  use Ecto.Repo,
    otp_app: :conductor_recipe,
    adapter: Ecto.Adapters.Postgres
end
