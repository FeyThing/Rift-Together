return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 11,
  height = 9,
  tilewidth = 64,
  tileheight = 64,
  nextlayerid = 3,
  nextobjectid = 12,
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
      width = 11,
      height = 9,
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
        0, 0, 0, 9, 9, 9, 9, 9, 0, 9, 0,
        0, 9, 9, 9, 9, 9, 9, 9, 9, 0, 0,
        0, 9, 9, 6, 6, 6, 6, 6, 9, 9, 0,
        0, 9, 9, 6, 10, 10, 10, 6, 9, 9, 0,
        0, 0, 9, 6, 10, 10, 10, 6, 9, 9, 9,
        9, 9, 9, 6, 10, 10, 10, 6, 9, 9, 0,
        0, 9, 9, 6, 6, 6, 6, 6, 9, 9, 0,
        0, 0, 9, 9, 9, 0, 9, 9, 9, 0, 0,
        0, 0, 9, 0, 0, 0, 0, 9, 0, 0, 0
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
          x = 443.542,
          y = 188.413,
          width = 29.7468,
          height = 33.3561,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "Junk Pillar",
          type = "junk_pillar",
          shape = "rectangle",
          x = 368.766,
          y = 153.794,
          width = 36.4154,
          height = 37.9327,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "Junk Lamp 2",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 230.691,
          y = 216.762,
          width = 25.7942,
          height = 25.0356,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 7,
          name = "Smelter",
          type = "vullard_smelter",
          shape = "rectangle",
          x = 318.695,
          y = 285.041,
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
          x = 443.114,
          y = 380.632,
          width = 24.2769,
          height = 24.2769,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "Junk Lamp 4",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 239.037,
          y = 376.08,
          width = 27.3115,
          height = 28.8288,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "Sign",
          type = "homesign",
          shape = "rectangle",
          x = 341.394,
          y = 220.009,
          width = 22.0009,
          height = 28.8288,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
