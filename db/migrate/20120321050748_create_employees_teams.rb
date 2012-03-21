class CreateEmployeesTeams < ActiveRecord::Migration
  def change
    create_table :employees_teams do |t|
      t.integer :employee_id
      t.integer :team_id
    end
  end
end
