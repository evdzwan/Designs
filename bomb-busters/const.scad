tolerance = .2;
shift = 1;

tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 1;
holder_count = 5;
holder_angle = 10;
holder_connector_radius = 2;
holder_connector_offset = 8;
holder_width = tile_width + 2 * holder_edge + 2 * tolerance;
holder_height = 25;
holder_depth = tile_depth + 3 * holder_edge + 2 * tolerance;

base_link = 8;
base_slot = 22 + 2 * tolerance;
base_spacing = 2;
base_rod_radius = 1;
base_rod_offset = cos(holder_angle) * (holder_connector_radius + holder_connector_offset);
base_width = holder_count * (holder_width + base_spacing);
base_height = 2;
base_depth = holder_height;

foot_radius = 2;
foot_height = .4;
