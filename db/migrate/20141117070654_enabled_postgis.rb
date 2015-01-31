class EnabledPostgis < ActiveRecord::Migration
  def change
    execute '
      DROP EXTENSION IF EXISTS postgis CASCADE;
      CREATE SCHEMA postgis;
      CREATE EXTENSION postgis WITH SCHEMA postgis;
      GRANT ALL ON postgis.geometry_columns TO PUBLIC;
      GRANT ALL ON postgis.spatial_ref_sys TO PUBLIC;
    '
  end
end
