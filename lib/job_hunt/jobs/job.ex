defmodule JobHunt.Jobs.Job do
  use Ecto.Schema
  import Ecto.Changeset

  schema "jobs" do
    field :job_id, :string
    field :title, :string
    field :company, :string
    field :location, :string
    field :salary, :integer
    field :remote, :boolean, default: false
    field :url, :string
    field :description, :string

    timestamps()
  end

  def changeset(job, attrs) do
    job
    |> cast(attrs, [:job_id, :title, :company, :location, :salary, :remote, :url, :description])
    |> validate_required([:job_id, :title, :company])
    |> unique_constraint(:job_id)
  end
end
