class CreateAdminAndRoles < ActiveRecord::Migration[5.1]
  def change
    admin = User.create! email: 'admin@admin.com', password: 'admin', system: true
    roles = %w[adminx common].map{ |rname| Role.create! name: rname, system: true }
    admin.roles = roles
  end
end
