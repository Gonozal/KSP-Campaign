class AddDefaultsToMissions < ActiveRecord::Migration
  def up
    change_column_default(:missions, :mission_category_id, 1)
    change_column_default(:missions, :minimal_time, 2)
    change_column_default(:missions, :maximal_time, 4)
    change_column_default(:missions, :reward, 10000)
  end

  def down
    change_column_default(:missions, :mission_category_id, nil)
    change_column_default(:missions, :minimal_time, nil)
    change_column_default(:missions, :maximal_time, nil)
    change_column_default(:missions, :reward, nil)
  end
end
