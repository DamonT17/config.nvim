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

-- Helper function to detect the license type from a LICENSE file in the project root.
local function get_license_type()
  local cwd = vim.fn.expand('%:p:h')

  while cwd ~= '/' do
    for _, name in ipairs({ 'LICENSE', 'LICENSE.txt', 'LICENSE.md', 'LICENCE', 'LICENCE.txt' }) do
      local path = cwd .. '/' .. name
      if vim.fn.filereadable(path) == 1 then
        local lines = read_lines(path)
        local header = {}
        for idx = 1, math.min(5, #lines) do
          table.insert(header, lines[idx]:lower())
        end
        local content = table.concat(header, ' ')

        if content:find('mit license') then
          return 'MIT'
        elseif content:find('apache license') then
          return content:find('version 2') and 'Apache-2.0' or 'Apache'
        elseif content:find('gnu lesser general public license') then
          if content:find('version 3') then
            return 'LGPL-3.0'
          end
          if content:find('version 2') then
            return 'LGPL-2.0'
          end
          return 'LGPL'
        elseif content:find('gnu general public license') then
          if content:find('version 3') then
            return 'GPL-3.0'
          end
          if content:find('version 2') then
            return 'GPL-2.0'
          end
          return 'GPL'
        elseif content:find('bsd 2%-clause') then
          return 'BSD-2-Clause'
        elseif content:find('bsd 3%-clause') then
          return 'BSD-3-Clause'
        elseif content:find('mozilla public license') then
          return 'MPL-2.0'
        elseif content:find('isc license') then
          return 'ISC'
        elseif content:find('the unlicense') then
          return 'Unlicense'
        elseif content:find('boost software license') then
          return 'BSL-1.0'
        end
        return 'LICENSE'
      end
    end
    cwd = vim.fn.fnamemodify(cwd, ':h')
  end

  return '<LICENSE>'
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
    trig = 'prj_header',
    name = 'C++ Projects File Header',
    desc = 'Doxygen file header for C++ projects',
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
      '// Distributed under the ',
    }),
    f(function()
      return get_license_type()
    end),
    t({
      ' License.',
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
      '///',
      '//===-----------------------------------------------------------------------------------------===//',
      '',
      '',
    }),
    i(0),
  }),
  -- Doxygen wrapper for file content declarations
  s({
    trig = 'prj_dox',
    name = 'C++ Projects Doxygen Wrapper',
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
