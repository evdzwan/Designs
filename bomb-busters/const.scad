tolerance = .4;
shift = 1;

tile_width = 14;
tile_height = 46;
tile_indicator_height = 22;
tile_depth = 2;

holder_count = 7;
holder_angle_min = 10;
holder_angle_max = 100;
holder_connector_offset = 15;
holder_connector_radius = 4;
holder_connector_inset = 1.5;
holder_connector_width = 8;
holder_edge = 2;
holder_head = 4;
holder_foot = 4;
holder_width = tile_width + 2 * (holder_edge + tolerance);
holder_depth = tile_depth + 2 * (holder_edge + 2 * tolerance);
holder_height = tile_height + 2 * (holder_edge + tolerance);

foot_width = 10;
foot_radius = 1.6;

base_width = holder_count * (holder_width + 2 * tolerance);
base_depth = 25;
base_thickness = 2;
base_scale_diff = .1;
base_radius = 2;
base_foot = 7;
