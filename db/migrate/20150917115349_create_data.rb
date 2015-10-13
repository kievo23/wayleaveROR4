class CreateData < ActiveRecord::Migration
  def change
    create_table :data do |t|
      t.string :permit_no
      t.string :route
      t.string :carriageway
      t.string :footpath
      t.string :verge
      t.string :amount_paid
      t.string :date_paid
      t.text :Remarks
      t.string :permit
      t.string :wayleave_file

      t.timestamps null: false
    end
  end
end
