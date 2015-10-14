class AddColumnProcedureCount < ActiveRecord::Migration
  def change
    add_column :suits, :procedure_count, :integer, :default => 0
  end
end
