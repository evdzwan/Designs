shift = 1;
tolerance = .2;

tile_width = 14;
tile_height = 45;
tile_depth = 2;

holder_edge = 2;
holder_count = 5;
holder_spacing = 2;
holder_angle_min = 10;
holder_angle_max = 100;
holder_connector_radius = 2;
holder_connector_offset = 12;
holder_connector_inner_width = 8;
holder_connector_outer_width = 14;
holder_width = tile_width + 2 * holder_edge + 4 * tolerance;
holder_height = tile_height + 2 * holder_edge + 8 * tolerance;
holder_depth = tile_depth + holder_edge + 4 * tolerance;

base_link_radius = 2;
base_link_height = base_link_radius;
base_radius = 2 * holder_connector_radius;
base_width = holder_count * (holder_width + holder_spacing);
base_depth = holder_height - 5 * holder_edge - holder_connector_offset;

foot_radius = 4;
foot_width = base_depth - 2 * foot_radius;
foot_height = 1;
