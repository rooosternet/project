class AddDriibleToProfile < ActiveRecord::Migration
  def change
    add_column :profiles, :dribbble, :string
  end
end
