class AddNameToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :name, :string
    add_column :users, :gender, :int
    add_column :users, :location, :string
    add_column :users, :age, :int
  end
end
