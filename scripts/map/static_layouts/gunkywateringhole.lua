return {
  version = "1.11",
  luaversion = "5.1",
  tiledversion = "1.11.2",
  class = "",
  orientation = "orthogonal",
  renderorder = "right-down",
  width = 11,
  height = 11,
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
      width = 11,
      height = 11,
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
        0, 6, 0, 0, 0, 0, 0, 0, 0, 6, 6,
        0, 6, 0, 11, 6, 0, 11, 11, 0, 6, 6,
        6, 0, 11, 11, 11, 11, 11, 11, 11, 6, 0,
        0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0,
        0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0,
        0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0,
        0, 11, 11, 11, 11, 11, 11, 11, 11, 11, 0,
        0, 0, 11, 11, 11, 11, 11, 11, 11, 0, 6,
        6, 6, 0, 11, 11, 11, 11, 11, 0, 6, 6,
        0, 6, 0, 0, 0, 0, 0, 0, 6, 0, 0
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
          x = 265.333,
          y = 61,
          width = 36.3333,
          height = 38.6666,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 4,
          name = "Drum",
          type = "barrel_radioactive",
          shape = "rectangle",
          x = 385,
          y = 258,
          width = 58,
          height = 59,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 5,
          name = "More Drums",
          type = "barrel_radioactive",
          shape = "rectangle",
          x = 195,
          y = 380,
          width = 60,
          height = 63,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "Torren Pllar",
          type = "torrenivdesert_pillar_small",
          shape = "rectangle",
          x = 646,
          y = 262,
          width = 51,
          height = 51,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 6,
          name = "Torren Pillar Again",
          type = "torrenivdesert_pillar_small",
          shape = "rectangle",
          x = -1,
          y = 390,
          width = 55,
          height = 50,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 8,
          name = "Big Pillar",
          type = "torrenivdesert_pillar",
          shape = "rectangle",
          x = 453,
          y = 3,
          width = 52,
          height = 52,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 9,
          name = "Big Pillar Again",
          type = "torrenivdesert_pillar",
          shape = "rectangle",
          x = 0,
          y = 260,
          width = 34,
          height = 36,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "Big Pillar Once More",
          type = "torrenivdesert_pillar",
          shape = "rectangle",
          x = 568,
          y = 569,
          width = 41,
          height = 38,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 11,
          name = "Torren Pillar Once More",
          type = "torrenivdesert_pillar_small",
          shape = "rectangle",
          x = 26,
          y = 22,
          width = 36,
          height = 32,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 14,
          name = "Tree",
          type = "luminoustree",
          shape = "rectangle",
          x = 213,
          y = 16,
          width = 35,
          height = 36,
          rotation = 0,
          visible = true,
          properties = {}
        },
        {
          id = 15,
          name = "Dead Guy",
          type = "skeleton",
          shape = "rectangle",
          x = 334,
          y = 31,
          width = 48,
          height = 46,
          rotation = 0,
          visible = true,
          properties = {}
        }
      }
    }
  }
}
