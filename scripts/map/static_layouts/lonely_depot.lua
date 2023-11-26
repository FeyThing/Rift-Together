return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 5,
  height = 5,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 3,
  nextobjectid = 11,
  properties = {},
  tilesets = {
    {
      name = "Don't Starve Together Terrains",
      firstgid = 1,
      filename = "C:/../../Don't Starve Mod Tools/mod_tools/Tiled/Don't Starve Together Tileset/Don't Starve Together Terrains.tsx"
    },
    {
      name = "Don't Starve Together Terrains",
      firstgid = 180,
      filename = "../../../../../../Don't Starve Mod Tools/mod_tools/Tiled/Don't Starve Together Tileset/Don't Starve Together Terrains.tsx"
    }
  },
  layers = {
    {
      type = "tilelayer",
      x = 0,
      y = 0,
      width = 5,
      height = 5,
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
        6, 6, 6, 6, 6,
        6, 10, 10, 10, 6,
        6, 10, 10, 10, 6,
        6, 10, 10, 10, 6,
        6, 6, 6, 6, 6
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
          id = 3,
          name = "Junk Lamp",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 253.818,
          y = 66.4827,
          width = 37.3333,
          height = 38.6667,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "Junk Pillar",
          type = "junk_pillar",
          shape = "rectangle",
          x = 176.766,
          y = 18.9663,
          width = 40.9673,
          height = 44.7606,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "Junk Lamp 2",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 21.2423,
          y = 88.7624,
          width = 41.7259,
          height = 41.7259,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "Smelter",
          type = "vullard_smelter",
          shape = "rectangle",
          x = 126.695,
          y = 157.041,
          width = 65.2442,
          height = 68.2788,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "Junk Lamp3",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 250.356,
          y = 258.701,
          width = 45.5192,
          height = 44.7606,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "Junk Lamp 4",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 28.8288,
          y = 258.701,
          width = 40.2086,
          height = 44.0019,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
