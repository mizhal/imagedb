class AddSlugAndSystemToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :slug, :string
    add_index :users, :slug, unique: true

    add_column :users, :system, :boolean, default: false
  end
end
