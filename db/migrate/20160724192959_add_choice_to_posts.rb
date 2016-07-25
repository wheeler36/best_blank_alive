class AddChoiceToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :choice, :string
  end
end
