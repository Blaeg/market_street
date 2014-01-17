class DropAccountingAdjustment < ActiveRecord::Migration
  def change
  	drop_table :accounting_adjustments
  end
end
