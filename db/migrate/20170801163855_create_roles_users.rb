class CreateRolesUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :roles_users, id: false do |t|
      t.belongs_to :user, foreign_key: true
      t.belongs_to :role, foreign_key: true

      t.timestamps
    end

    add_index :roles_users, %i[user_id role_id]
  end
end
