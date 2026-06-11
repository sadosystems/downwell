noDmg4wall = 0;

for (i = 0; i < memWallCount; i += 1)
{
    if (bulletMemWall[i] == other.id)
        noDmg4wall = 1;
}

if (!noDmg4wall)
{
    other.wallHp -= 50;
    bulletMemWall[memWallCount] = other.id;
    memWallCount += 1;
}
