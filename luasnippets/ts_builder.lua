local ls = require("luasnip")

-- some shorthands...
local s = ls.snippet
local i = ls.insert_node
local f = ls.function_node
local rep = require("luasnip.extras").rep
local fmt = require("luasnip.extras.fmt").fmt

-- get the filename without extension
local builderName = vim.fn.expand('%:t:r')
-- get the filename (without the last part after camel case)
local entity = builderName:match("^%u%l+")

local function capitalize(str)
  str = str[1][1]
  return str:sub(1, 1):upper() .. str:sub(2)
end

ls.add_snippets("typescript", {
  -- builder - creates a new builder with context of the current file.
  s("builder",
    fmt([[
export class {} {{
  constructor(builderfunction: (builder: {}) => void = (e) => e) {{
    builderfunction(this);
  }}

  build(): {} {{
    return {{}} as {}
  }}
}}]], {
      i(1, builderName),
      i(2, builderName),
      i(3, entity),
      i(4, entity),
    })),

  -- withfield - adds a 'with' function for a field to the current builder.
  s("withfield",
    fmt([[
private {}: {} = {};

with{}({}: {}): this {{
  this.{} = {};
  return this;
}}
]], {
      i(1, "fieldname"), i(2, "fieldtype"), i(3, "defaultvalue"),
      f(capitalize, { 1 }), rep(1), rep(2),
      rep(1), rep(1),
    })),

  s("withbuild",
    fmt([[
private {}Builder: {}Builder = new {}Builder();

with{}(
  builderFunction: (builder: {}Builder) => void = (e) => e
): this {{
  builderFunction(this.{}Builder);
  return this;
}}
]], {
      i(1, "fieldname"), f(capitalize, { 1 }), f(capitalize, { 1 }),
      f(capitalize, { 1 }),
      f(capitalize, { 1 }),
      rep(1),
    })),

  -- withNull - Adds a 'with' function for a nullable sub-builder to the current builder.
  s("withNull",
    fmt([[
private {}Builder: {}Builder;

with{}(builderFunction: (builder: {}Builder) => void = (e) => e): this {{
  const newBuiler = new {}Builder();
  builderFunction(newBuiler);
  this.{}Builder = newBuiler;
  return this;
}}
]], {
      i(1, "fieldname"), f(capitalize, { 1 }),
      f(capitalize, { 1 }), f(capitalize, { 1 }),
      f(capitalize, { 1 }),
      rep(1),
    })),

  -- withArr - Adda a 'with' function to append to a list of sub-builders.
  s("withArr",
    fmt([[
private {}Builders: {}Builder[] = [];

with{}(builderFunction: (builder: {}Builder) => void = (e) => e): this {{
  const newBuiler = new {}Builder();
  builderFunction(newBuiler);
  this.{}Builders.push(newBuiler);
  return this;
}}
]], {
      i(1, "fieldname"), f(capitalize, { 1 }),
      f(capitalize, { 1 }), f(capitalize, { 1 }),
      f(capitalize, { 1 }),
      rep(1),
    })),
})
