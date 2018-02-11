class AddNoticeDateToPagos < ActiveRecord::Migration
  def change
    add_column :pagos, :notice_date, :date
  end
end
