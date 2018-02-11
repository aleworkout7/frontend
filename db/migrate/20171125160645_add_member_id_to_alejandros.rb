class AddMemberIdToAlejandros < ActiveRecord::Migration
  def change
    add_column :alejandros, :member_id, :integer
  end
end
