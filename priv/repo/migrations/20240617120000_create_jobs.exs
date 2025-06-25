defmodule JobHunt.Repo.Migrations.CreateJobs do
  use Ecto.Migration

  def change do
    create table(:jobs) do
      add :job_id, :string, null: false
      add :title, :string, null: false
      add :company, :string, null: false
      add :location, :string
      add :salary, :integer
      add :remote, :boolean, default: false
      add :url, :string
      add :description, :text

      timestamps()
    end

    create unique_index(:jobs, [:job_id])
  end
end
