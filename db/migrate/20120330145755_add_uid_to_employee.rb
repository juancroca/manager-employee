class AddUidToEmployee < ActiveRecord::Migration
  def change
    add_column :employees, :uid, :string

  end
end
