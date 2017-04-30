
include <config.scad>;

module step_positive()
{
    color(step_color)
    translate([
        -step_x/2,
        0,
        material_z/2
        ])
    cube([
        step_x,
        step_y,
        material_z
        ], center=true);
}

module step()
{
    difference()
    {
        step_positive();

        // right side nose cutout
        translate([
            -step_support_radius + material_z*3/2,,
            -step_y/2 + stairs_support_inset,
            material_z/2
            ])
        cube([
            material_z,
            material_z,
            material_z*1.2
            ], center=true);

        // left side nose cutout
        translate([
            -step_support_radius + material_z*3/2,,
            +step_y/2 - stairs_support_inset,
            material_z/2
            ])
        cube([
            material_z,
            material_z,
            material_z*1.2
            ], center=true);
    }
}

module step_support_cylinder()
{
    intersection()
    {
        // lower left quadrant of the xz-plane
        translate([
            -stairs_x/2,
            0,
            -stairs_z/2
            ])
        cube([
            stairs_x,
            material_z,
            stairs_z
            ], center=true);

        // cylinder
        rotate([
            90,
            0,
            0
            ])
        cylinder(
            r=step_support_radius,
            h=material_z,
            center=true
            );
    }
}

module step_support()
{
    color(support_color)
    {
        step_support_cylinder();

        // nose
        translate([
            -step_support_radius + material_z*3/2,
            0,
            material_z/2
            ])
        cube([
            material_z,
            material_z,
            material_z + nothing
            ], center=true);
    }
}

step();

/*
translate([
    0,
    -step_y/2 + stairs_support_inset,
    0
    ])
step_support();
*/