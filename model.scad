
include <config.scad>;
use <support.scad>;
use <step.scad>;

module model()
{
    // front support
    translate([
        0,
        -step_y/2 + stairs_support_inset,
        0
        ])
    support();

    // back support
    translate([
        0,
        +step_y/2 - stairs_support_inset,
        0
        ])
    support();

    // the steps
    for (i=[1:step_count])
    {
        translate([
            i*stairs_x/step_count,
            0,
            i*stairs_z/step_count
            ])
        step();
    }
}

model();
