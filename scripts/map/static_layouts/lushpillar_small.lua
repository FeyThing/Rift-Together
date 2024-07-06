return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 3,
  height = 3,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 3,
  nextobjectid = 16,
  properties = {},
  tilesets = {
    {
      name = "Don't Starve Together Terrains",
      firstgid = 1,
      filename = "D:/Steam/steamapps/common/Don't Starve Mod Tools/mod_tools/Tiled/Don't Starve Together Tileset/Don't Starve Together Terrains.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 3,
      height = 3,
      id = 1,
      name = "BG_TILES",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      encoding = "lua",
      data = {
        0, 0, 0,
        0, 0, 0,
        0, 0, 0
      }
    },
    {
      type = "objectgroup",
      draworder = "topdown",
      id = 2,
      name = "FG_OBJECTS",
      class = "",
      visible = true,
      opacity = 1,
      offsetx = 0,
      offsety = 0,
      parallaxx = 1,
      parallaxy = 1,
      properties = {},
      objects = {
        {
          id = 11,
          name = "Torren Pillar smol",
          type = "torrenivlush_pillar_small",
          shape = "rectangle",
          x = 75.3333,
          y = 74,
          width = 36,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
