if (surface_exists(global.surfaceShade))
{
    surface_set_target(global.surfaceFx);
    draw_set_blend_mode(bm_subtract);
    draw_surface(global.surfaceShade, 0, 0);
    surface_reset_target();
    surface_set_target(global.surfaceButton);
    draw_surface(global.surfaceShade, 0, 0);
    draw_set_blend_mode(bm_normal);
    surface_reset_target();
}
else
{
    global.surfaceShade = surface_create(160, global.g_cameraHeight);
}

if (surface_exists(global.surfaceFx))
    draw_surface(global.surfaceFx, __view_get(e__VW.XView, 0), __view_get(e__VW.YView, 0));
else
    global.surfaceFx = surface_create(160, global.g_cameraHeight);

if (surface_exists(global.surfaceDissipate))
    draw_surface(global.surfaceDissipate, __view_get(e__VW.XView, 0), __view_get(e__VW.YView, 0));
else
    global.surfaceDissipate = surface_create(160, global.g_cameraHeight);

if (surface_exists(global.surfaceButton))
    draw_surface(global.surfaceButton, __view_get(e__VW.XView, 0), __view_get(e__VW.YView, 0));
else
    global.surfaceButton = surface_create(160, global.g_cameraHeight);

if (global.isPC)
{
    if (!global.disp4x3)
        scrDrawHud();
    
    if (global.disp4x3)
        scrDrawHud4x3Top();
}
else if (global.isTablet)
{
    if (!global.isAndroid)
    {
        if (!global.lowSpec)
            scrDrawHud4x3Top();
        else
            scrDrawHud();
    }
    else
    {
        scrDrawHud();
    }
}
else
{
    scrDrawHud();
}

enum e__VW
{
    XView,
    YView,
    WView,
    HView,
    Angle,
    HBorder,
    VBorder,
    HSpeed,
    VSpeed,
    Object,
    Visible,
    XPort,
    YPort,
    WPort,
    HPort,
    Camera,
    SurfaceID
}
