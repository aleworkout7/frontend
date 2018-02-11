class RemoveFieldNameFromAlejandro < ActiveRecord::Migration
  def change
    remove_column :alejandros, :id_member, :integer
  end
end
