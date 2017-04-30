
include <config.scad>;
use <step.scad>;

module support_triangle()
{
    // rotate into xz-plane
    rotate([
        90,
        0,
        0
        ])
    // make 3d
    linear_extrude(material_z, center=true)
    // triangle
    polygon([
        [0, 0],
        [stairs_x, 0],
        [stairs_x, stairs_z]
        ]);
}

module support_triangle_without_corner()
{
    difference()
    {
        support_triangle();

        translate([
            stairs_x/(step_count*4),
            0,
            stairs_z/2 - nothing
            ])
        cube([
            stairs_x/(2*step_count),
            material_z*1.2,
            stairs_z
            ], center=true);
    }
}

module support_with_step_supports()
{
    // begin with a triangle
    support_triangle_without_corner();

    // add step supports
    for (i=[1:step_count])
    {
        translate([
            i*stairs_x/step_count,
            0,
            i*stairs_z/step_count
            ])
        step_support();
    }
}

module support()
{
    color(support_color)
    intersection()
    {
        support_with_step_supports();

        // upper right quadrant of the xz-plane
        translate([
            0,
            0,
            +stairs_z
            ])
        cube([
            2*stairs_x,
            material_z,
            2*stairs_z
            ], center=true);
    }
}

support();
