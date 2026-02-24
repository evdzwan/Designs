shift = 1;
tolerance = .2;

tile_count = 5;
tile_radius = 1;
tile_width = 14;
tile_height = 45;
tile_depth = 2;

indicator_radius = 1;
indicator_width = tile_width;
indicator_height = 22;
indicator_depth = 2;

holder_edge = 2;
holder_angle = 10;
holder_connector_radius = 2;
holder_connector_offset = 12;
holder_connector_width = 8;
holder_width = tile_width + 2 * holder_edge + 4 * tolerance;
holder_height = tile_height + 2 * holder_edge + 8 * tolerance;
holder_depth = tile_depth + holder_edge + 4 * tolerance;

base_radius = 4;
base_spacing = 2;
base_width = tile_count * (holder_width + base_spacing);
base_depth = 32;

link_radius = 2;
link_height = link_radius;

foot_radius = 4;
foot_height = 1;
