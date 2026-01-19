local ls = require('luasnip')

local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node

--------------------------------------------------------------------------------
--- Helper Functions
--------------------------------------------------------------------------------

-- Helper function to read lines from a file
--- @param path string: Path to the file
--- @return table: Lines of the file
local function read_lines(path)
  local file = io.open(path, 'r')
  if not file then
    return {}
  end
  local lines = {}
  for line in file:lines() do
    table.insert(lines, line)
  end

  file:close()
  return lines
end

-- Helper function to find project name from root level CMakeLists.txt file.
local function get_cmake_project_name()
  local cwd = vim.fn.expand('%:p:h')

  while cwd ~= '/' do
    local cmake = cwd .. '/CMakeLists.txt'
    if vim.fn.filereadable(cmake) == 1 then
      local lines = read_lines(cmake)
      for i, line in ipairs(lines) do
        if line:match('^%s*project%s*%(') then
          local next_line = lines[i + 1]
          if next_line then
            local project_line = next_line:gsub('#.*', ''):match('^%s*(%S+)')
            if project_line then
              return project_line
            end
          end
        end
      end
    end

    cwd = vim.fn.fnamemodify(cwd, ':h')
  end

  return 'UnknownProject'
end

--------------------------------------------------------------------------------
--- Snippets
--------------------------------------------------------------------------------
ls.add_snippets('cpp', {
  -- [[ Umbra Projects custom snippets ]]
  -- Doxygen file header
  s({
    trig = 'upjx_header',
    name = 'Umbra Projects File Header',
    desc = 'Doxygen file header for Umbra Projects',
  }, {
    t({
      '//===-----------------------------------------------------------------------------------------===//',
      '//',
      '// Part of the ',
    }),
    f(function()
      return get_cmake_project_name()
    end),
    t({
      ' project.',
      '// @copyright Copyright (c) ',
    }),
    f(function()
      return os.date('%Y')
    end),
    t(', '),
    i(1, 'name'),
    t(' & '),
    i(2, 'team'),
    t({
      ' contributors.',
      '//',
      '// Distributed under the MIT License.',
      '// Please see the LICENSE file in the root of this repository for more information.',
      '//',
      '//===-----------------------------------------------------------------------------------------===//',
      '///',
      '/// @file ',
    }),
    f(function()
      return vim.fn.expand('%:t')
    end),
    t({
      '',
      '/// ',
    }),
    i(3, 'File description'),
    t({
      '',
      '//===-----------------------------------------------------------------------------------------===//',
      '',
      '',
    }),
    i(0),
  }),
  -- Doxygen wrapper for file content declarations
  s({
    trig = 'upjx_dox',
    name = 'Umbra Projects Doxygen Wrapper',
    desc = 'Doxygen wrapper for file content declarations',
  }, {
    t({
      '//===----------------------------------------------------------------------===//',
      '/// @name ',
    }),
    i(1, 'Section (e.g., Classes, Methods)'),
    t({
      '',
      '//===----------------------------------------------------------------------===//',
      '///@{',
      '',
    }),
    i(0),
    t({
      '',
      '///@}',
    }),
  }),
  -- Function documentation comment snippet
  s({
    trig = 'cmt',
    name = 'Comment Block',
    desc = 'Documentation comment block',
  }, {
    t({
      '/**',
      ' * ',
    }),
    i(1, 'Brief description.'),
    t({
      '',
      ' *',
      ' * @param ',
    }),
    i(2, 'param'),
    t(' '),
    i(3, 'description'),
    t({
      '',
      ' *',
      ' * @returns ',
    }),
    i(4, 'Return value description.'),
    t({
      '',
      ' */',
    }),
  }),
})
