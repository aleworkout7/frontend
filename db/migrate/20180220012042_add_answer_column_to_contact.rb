class AddAnswerColumnToContact < ActiveRecord::Migration
  def change
    add_column :contacts, :answer, :text
  end
end
