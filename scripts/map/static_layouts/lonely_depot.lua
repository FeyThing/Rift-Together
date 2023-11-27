return {
  version = "1.10",
  luaversion = "5.1",
  tiledversion = "1.10.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 11,
  height = 9,
  tilewidth = 94,
  tileheight = 94,
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
          x = 445.818,
          y = 194.483,
          width = 37.3333,
          height = 38.9997,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "Junk Pillar",
          type = "junk_pillar",
          shape = "rectangle",
          x = 398.799,
          y = 149.999,
          width = 40.9973,
          height = 44.7909,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "Junk Lamp 2",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 213.242,
          y = 219.792,
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
          x = 318.995,
          y = 285.041,
          width = 95.2442,
          height = 98.2788,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "Junk Lamp3",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 442.359,
          y = 389.701,
          width = 45.5192,
          height = 44.7909,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "Junk Lamp 4",
          type = "vullard_lamp",
          shape = "rectangle",
          x = 220.829,
          y = 389.701,
          width = 40.2089,
          height = 44.0019,
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
