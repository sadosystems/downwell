if (hitStun)
{
    shader_set(shaderHit);
    draw_self();
    shader_reset();
}
else
{
    draw_self();
}
