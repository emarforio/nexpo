defmodule Nexpo.Repo.Migrations.CreateCompanyCategoryAttribute do
  use Ecto.Migration

  def change do
    create table(:company_category_attributes) do
      add :title, :string
      add :type, :string
      add :value, :string
      add :company_category_id, references(:company_categories)

      timestamps()
    end

  end
end
