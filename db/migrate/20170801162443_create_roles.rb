class CreateRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :roles do |t|
      t.string :name
      t.string :slug
      t.boolean :system, default: false

      t.timestamps
    end
    add_index :roles, :slug, unique: true
  end
end
