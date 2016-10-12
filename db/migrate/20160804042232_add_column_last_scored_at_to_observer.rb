class AddColumnLastScoredAtToObserver < ActiveRecord::Migration
  def change
    add_column :court_observers, :last_scored_at, :date
    add_index :court_observers, :last_scored_at
  end
end
