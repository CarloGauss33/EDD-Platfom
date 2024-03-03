class RemoveScoreFromResponse < ActiveRecord::Migration[6.1]
  def change
    safety_assured { remove_column :enrollments_loaded_at, :score, :integer }
  end
end
