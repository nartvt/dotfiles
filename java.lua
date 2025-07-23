-- Java ftplugin for JDTLS configuration
local status_ok, jdtls = pcall(require, 'jdtls')
if not status_ok then
  vim.notify("JDTLS not found. Please install nvim-jdtls.", vim.log.levels.ERROR)
  return
end

-- Don't set up JDTLS if it's already running for this buffer
local clients = vim.lsp.get_clients({ bufnr = 0, name = 'jdtls' })
if #clients > 0 then
  vim.notify("JDTLS already running for this buffer", vim.log.levels.INFO)
  return
end

-- Debug info
vim.notify("Setting up JDTLS for Java file...", vim.log.levels.INFO)

-- Get proper OS config
local os_config = "mac_arm"
if vim.fn.has("mac") == 1 then
  if vim.fn.system("uname -m"):find("arm64") then
    os_config = "mac_arm"
  else
    os_config = "mac"
  end
elseif vim.fn.has("unix") == 1 then
  os_config = "linux"
elseif vim.fn.has("win32") == 1 then
  os_config = "win"
end

-- Setup workspace
local home = os.getenv("HOME")
local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
local workspace_dir = vim.fn.stdpath("cache") .. "/jdtls/workspace/" .. project_name

-- Lombok configuration
local lombok_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/lombok.jar"

-- LSP capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

-- Testing and debugging bundles
local bundles = {}
local mason_path = vim.fn.stdpath("data") .. "/mason/"
if vim.fn.isdirectory(mason_path .. "packages/java-test") == 1 then
  vim.list_extend(bundles, vim.split(vim.fn.glob(mason_path .. "packages/java-test/extension/server/*.jar"), "\n"))
end
if vim.fn.isdirectory(mason_path .. "packages/java-debug-adapter") == 1 then
  vim.list_extend(
    bundles,
    vim.split(vim.fn.glob(mason_path .. "packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-*.jar"), "\n")
  )
end

local config = {
  cmd = {
    "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home/bin/java",
    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-Djava.awt.headless=true",
    "-Xms1g",
    "-Xmx4G",
    "-XX:+UseG1GC",
    "-XX:+UseStringDeduplication",
    "--add-modules=ALL-SYSTEM",
    "--add-opens", "java.base/java.util=ALL-UNNAMED",
    "--add-opens", "java.base/java.lang=ALL-UNNAMED",
    "-javaagent:" .. lombok_path,
    "-jar", vim.fn.glob(vim.fn.stdpath("data") .. "/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_*.jar"),
    "-configuration", vim.fn.stdpath("data") .. "/mason/packages/jdtls/config_" .. os_config,
    "-data", workspace_dir,
  },
  
  root_dir = require('jdtls.setup').find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }),
  
  settings = {
    java = {
      home = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home",
      eclipse = {
        downloadSources = true,
      },
      configuration = {
        updateBuildConfiguration = "interactive",
        runtimes = {
          {
            name = "JavaSE-22",
            path = "/Library/Java/JavaVirtualMachines/jdk-22.jdk/Contents/Home",
            default = true,
          },
          {
            name = "JavaSE-17",
            path = "/Library/Java/JavaVirtualMachines/openjdk-17.jdk/Contents/Home",
            default = false,
          },
          {
            name = "JavaSE-1.8",
            path = "/Library/Java/JavaVirtualMachines/jdk-1.8.jdk/Contents/Home",
            default = false,
          }
        }
      },
      maven = {
        downloadSources = true,
      },
      implementationsCodeLens = {
        enabled = true,
      },
      referencesCodeLens = {
        enabled = true,
      },
      references = {
        includeDecompiledSources = true,
      },
      inlayHints = {
        parameterNames = {
          enabled = "all",
        },
      },
      format = {
        enabled = true,
        insertSpaces = true,
        tabSize = 4,
      },
      preferences = {
        -- Basic indentation settings
        ["org.eclipse.jdt.core.formatter.tabulation.char"] = "space",
        ["org.eclipse.jdt.core.formatter.tabulation.size"] = "4",
        ["org.eclipse.jdt.core.formatter.indentation.size"] = "4",
        ["org.eclipse.jdt.core.formatter.continuation_indentation"] = "4",
        ["org.eclipse.jdt.core.formatter.continuation_indentation_for_array_initializer"] = "4",
        
        -- Indentation behavior
        ["org.eclipse.jdt.core.formatter.indent_statements_compare_to_block"] = "true",
        ["org.eclipse.jdt.core.formatter.indent_statements_compare_to_body"] = "true",
        ["org.eclipse.jdt.core.formatter.indent_body_declarations_compare_to_type_header"] = "true",
        ["org.eclipse.jdt.core.formatter.indent_breaks_compare_to_cases"] = "true",
        ["org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_cases"] = "true",
        ["org.eclipse.jdt.core.formatter.indent_switchstatements_compare_to_switch"] = "true",
        
        -- Assignment operator spacing (key requirement)
        ["org.eclipse.jdt.core.formatter.insert_space_before_assignment_operator"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_after_assignment_operator"] = "insert",
        
        -- Other spacing
        ["org.eclipse.jdt.core.formatter.insert_space_before_binary_operator"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_after_binary_operator"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_declaration_parameters"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_after_comma_in_method_invocation_arguments"] = "insert",
        
        -- Brace positions
        ["org.eclipse.jdt.core.formatter.brace_position_for_type_declaration"] = "end_of_line",
        ["org.eclipse.jdt.core.formatter.brace_position_for_method_declaration"] = "end_of_line",
        ["org.eclipse.jdt.core.formatter.brace_position_for_constructor_declaration"] = "end_of_line",
        ["org.eclipse.jdt.core.formatter.brace_position_for_block"] = "end_of_line",
        ["org.eclipse.jdt.core.formatter.brace_position_for_switch"] = "end_of_line",
        ["org.eclipse.jdt.core.formatter.brace_position_for_array_initializer"] = "end_of_line",
        
        -- Spaces before opening braces and parentheses
        ["org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_method_declaration"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_type_declaration"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_before_opening_brace_in_block"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_if"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_for"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_while"] = "insert",
        ["org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_declaration"] = "do not insert",
        ["org.eclipse.jdt.core.formatter.insert_space_before_opening_paren_in_method_invocation"] = "do not insert",
        
        -- Line length
        ["org.eclipse.jdt.core.formatter.lineSplit"] = "240",
        ["org.eclipse.jdt.core.formatter.comment.line_length"] = "240",
      },
      signatureHelp = {
        enabled = true,
      },
      contentProvider = {
        preferred = "fernflower",
      },
      completion = {
        favoriteStaticMembers = {
          "org.hamcrest.MatcherAssert.assertThat",
          "org.hamcrest.Matchers.*",
          "org.hamcrest.CoreMatchers.*",
          "org.junit.jupiter.api.Assertions.*",
          "java.util.Objects.requireNonNull",
          "java.util.Objects.requireNonNullElse",
          "org.mockito.Mockito.*"
        }
      },
      sources = {
        organizeImports = {
          starThreshold = 9999,
          staticStarThreshold = 9999,
        }
      },
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        }
      }
    }
  },
  
  capabilities = capabilities,
  
  init_options = {
    bundles = bundles,
  },
}

-- On attach function
config['on_attach'] = function(client, bufnr)
  -- Import LSP common on_attach
  local common_on_attach = require("lsp.common").on_attach
  if common_on_attach then
    common_on_attach(client, bufnr)
  end
  
  -- Enable formatting
  if client.server_capabilities.documentFormattingProvider then
    -- Format on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({ bufnr = bufnr })
      end,
    })
  end
  
  -- Enable codelens
  if client.server_capabilities.codeLensProvider then
    vim.lsp.codelens.refresh()
  end
  
  -- Setup DAP if available
  local status_ok, jdtls_dap = pcall(require, "jdtls.dap")
  if status_ok then
    jdtls_dap.setup_dap_main_class_configs()
  end
  
  -- Java-specific keymaps
  local bufopts = { noremap = true, silent = true, buffer = bufnr }
  local remap = require("me.util").remap
  
  -- Use standard LSP functions for navigation (they work better with JDTLS)
  remap('n', 'gd', vim.lsp.buf.definition, bufopts, "Go to definition (JDTLS)")
  remap('n', 'gi', vim.lsp.buf.implementation, bufopts, "Go to implementation (JDTLS)")
  remap('n', 'gr', '<cmd>Telescope lsp_references<cr>', bufopts, "Go to references (Telescope)")
  
  -- JDTLS specific commands
  remap('n', '<leader>co', function() require('jdtls').organize_imports() end, bufopts, "Organize imports")
  remap('n', '<leader>cf', function() vim.lsp.buf.format() end, bufopts, "Format code")
  remap('n', '<leader>cv', function() require('jdtls').extract_variable() end, bufopts, "Extract variable")
  remap('n', '<leader>cc', function() require('jdtls').extract_constant() end, bufopts, "Extract constant")
  remap('n', '<leader>cm', function() require('jdtls').extract_method() end, bufopts, "Extract method")
  remap('n', '<leader>ct', function() require('jdtls').test_nearest_method() end, bufopts, "Test method")
  remap('n', '<leader>cT', function() require('jdtls').test_class() end, bufopts, "Test class")
  
  -- Manual completion triggers
  remap('i', '<C-Space>', function() 
    local cmp_ok, cmp = pcall(require, 'cmp')
    if cmp_ok then
      cmp.complete()
    else
      vim.lsp.buf.completion()
    end
  end, bufopts, "Trigger LSP completion")
  
  remap('i', '<C-x><C-o>', function() 
    vim.lsp.buf.completion()
  end, bufopts, "Trigger omnifunc completion")
end

-- Auto-refresh codelens
vim.api.nvim_create_autocmd({ "BufWritePost" }, {
  pattern = { "*.java" },
  callback = function()
    local _, _ = pcall(vim.lsp.codelens.refresh)
  end,
})

-- Start JDTLS
vim.notify("Starting JDTLS with Lombok support...", vim.log.levels.INFO)
jdtls.start_or_attach(config)

-- Add a user command to check JDTLS status
vim.api.nvim_create_user_command('JdtlsStatus', function()
  local clients = vim.lsp.get_clients({ name = 'jdtls' })
  if #clients > 0 then
    vim.notify("JDTLS is running. Client ID: " .. clients[1].id, vim.log.levels.INFO)
    print("JDTLS server capabilities:")
    for key, value in pairs(clients[1].server_capabilities) do
      if value == true then
        print("  " .. key .. ": enabled")
      end
    end
  else
    vim.notify("JDTLS is not running", vim.log.levels.WARN)
  end
end, { desc = "Check JDTLS status" })

-- IntelliJ IDEA-style indentation configuration for Java
vim.bo.tabstop = 4          -- Tab width: 4 spaces (IntelliJ default)
vim.bo.shiftwidth = 4       -- Indentation width: 4 spaces
vim.bo.softtabstop = 4      -- Soft tab stop: 4 spaces
vim.bo.expandtab = true     -- Use spaces, not tabs (IntelliJ default)
vim.bo.smartindent = true   -- Smart indentation
vim.bo.cindent = true       -- C-style indentation (good for Java)
vim.bo.autoindent = true    -- Auto-indent new lines

-- IntelliJ-style C indentation options
vim.bo.cinoptions = table.concat({
  "(0",      -- Align function parameters
  "u0",      -- Align with opening parenthesis
  "U1",      -- Don't ignore opening parenthesis indentation
  "w1",      -- Align with case label instead of statement after case
  "Ws",      -- When indenting a line that starts with ) align with the matching (
  "m1",      -- Align closing parenthesis with opening
  "M0",      -- Don't add extra indent for function body
  "j1",      -- Align Java anonymous classes
  ")50",     -- Search for closing ) at most 50 lines away
  "*70",     -- Search for closing comment at most 70 lines away
  "#0",      -- Don't indent # (preprocessor) lines
  "g0",      -- C++ scope declarations (public, private, protected) at class level
  "h0",      -- C++ scope declarations relative to class
  "N-s",     -- Don't indent inside namespace
  "E-s"      -- Don't indent extern block
}, ",")

-- IntelliJ-style auto-indent triggers
vim.bo.cinkeys = "0{,0},0),:,0#,!^F,o,O,e,0=break,0=case,0=catch,0=do,0=else,0=finally,0=for,0=if,0=switch,0=try,0=while"

-- Additional IntelliJ-style settings
vim.bo.textwidth = 120      -- IntelliJ default line length
vim.bo.formatoptions = "tcqj"  -- Auto-formatting options
vim.bo.comments = "sl:/*,mb: *,elx: */,://,b:#,:%,:XCOMM,n:>,fb:-"
vim.bo.commentstring = "// %s"

-- Smart Tab behavior for Java
vim.keymap.set("i", "<Tab>", function()
  -- Handle completion menu
  local cmp_ok, cmp = pcall(require, 'cmp')
  if cmp_ok and cmp.visible() then
    cmp.select_next_item()
    return
  end
  
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before_cursor = line:sub(1, col)
  
  -- IntelliJ-style bracket handling: create proper structure
  if before_cursor:match("[{%(%[]%s*$") then
    local current_indent = line:match("^%s*")
    local inner_indent = current_indent .. "    "  -- 4 spaces for content
    local closing_indent = current_indent           -- Align closing with opening
    
    local keys = vim.api.nvim_replace_termcodes(
      "\n" .. inner_indent .. "\n" .. closing_indent .. "<Up><End>", 
      true, false, true
    )
    vim.api.nvim_feedkeys(keys, "n", false)
    return
  end
  
  -- IntelliJ continuation indent (8 spaces) for method chains, parameters
  local is_continuation = before_cursor:match("%.%s*$") or           -- method chaining
                         before_cursor:match(",%s*$") or            -- parameter continuation
                         before_cursor:match("&&%s*$") or           -- logical continuation
                         before_cursor:match("||%s*$") or           -- logical continuation
                         before_cursor:match("[+%-*/]%s*$") or      -- arithmetic continuation
                         before_cursor:match("=%s*$")               -- assignment continuation
  
  if is_continuation then
    vim.api.nvim_feedkeys("        ", "n", false)  -- 8 spaces (continuation indent)
    return
  end
  
  -- Standard 4-space indentation
  vim.api.nvim_feedkeys("    ", "n", false)
end, { buffer = true, desc = "Smart Tab for Java completion and indentation" })

-- Shift+Tab for previous completion item  
vim.keymap.set("i", "<S-Tab>", function()
  local cmp_ok, cmp = pcall(require, 'cmp')
  if cmp_ok and cmp.visible() then
    cmp.select_prev_item()
  else
    -- Fallback: outdent
    local line = vim.api.nvim_get_current_line()
    local col = vim.api.nvim_win_get_cursor(0)[2]
    local before_cursor = line:sub(1, col)
    if before_cursor:match("^%s+$") then
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<BS><BS><BS><BS>", true, false, true), "n", false)
    end
  end
end, { buffer = true, desc = "Previous completion item or outdent" })

-- IntelliJ-style equals spacing for Java
vim.keymap.set("i", "=", function()
  local line = vim.api.nvim_get_current_line()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  local before_cursor = line:sub(1, col)
  local after_cursor = line:sub(col + 1)
  
  -- Don't add spaces for ==, !=, <=, >=, +=, -=, etc.
  if before_cursor:match("[=!<>+%-*/%%]$") or after_cursor:match("^=") then
    vim.api.nvim_feedkeys("=", "n", false)
    return
  end
  
  -- Add spaces around = for assignments (IntelliJ style)
  local needs_space_before = not before_cursor:match("%s$") and before_cursor ~= ""
  local needs_space_after = not after_cursor:match("^%s") and after_cursor ~= ""
  
  local insert_text = ""
  if needs_space_before then insert_text = " " end
  insert_text = insert_text .. "="
  if needs_space_after then insert_text = insert_text .. " " end
  
  vim.api.nvim_feedkeys(insert_text, "n", false)
end, { buffer = true, desc = "IntelliJ-style equals spacing for Java" })

-- Command to demonstrate IntelliJ-style Java formatting
vim.api.nvim_create_user_command('IntelliJJavaDemo', function()
  local demo_code = {
    "public class IntelliJStyleDemo {",
    "    private static final String CONSTANT = \"value\";",
    "    ",
    "    public void demonstrateStyle() {",
    "        // Method chaining (8-space continuation)",
    "        String result = someObject",
    "                .method1()",
    "                .method2(parameter1,",
    "                        parameter2)",
    "                .method3();",
    "        ",
    "        // Conditional with proper spacing",
    "        if (condition1 &&",
    "                condition2 ||",
    "                condition3) {",
    "            doSomething();",
    "        }",
    "        ",
    "        // Array initialization",
    "        int[] array = {",
    "                1, 2, 3,",
    "                4, 5, 6",
    "        };",
    "        ",
    "        // Switch statement",
    "        switch (value) {",
    "            case 1:",
    "                handleCase1();",
    "                break;",
    "            case 2:",
    "                handleCase2();",
    "                break;",
    "            default:",
    "                handleDefault();",
    "        }",
    "    }",
    "}"
  }
  
  vim.cmd('new')
  vim.bo.filetype = 'java'
  vim.api.nvim_buf_set_lines(0, 0, -1, false, demo_code)
  
        vim.notify("📝 Java Style Demo Created!\n\n" ..
              "✅ FEATURES:\n" ..
              "  • Standard indent: 4 spaces\n" ..
              "  • Continuation indent: 8 spaces\n" ..
              "  • Smart Tab indentation\n" ..
              "  • Completion menu navigation\n" ..
              "  • Equals spacing: space = around = assignments\n\n" ..
              "🎹 KEYBINDINGS:\n" ..
              "  • Tab: Smart indentation and completion\n" ..
              "  • Shift+Tab: Previous completion item\n" ..
              "  • Ctrl+Space: Manual completion\n" ..
              "  • <leader>cf: Format code\n\n" ..
              "💡 TRY:\n" ..
              "  • Tab after '{' for bracket structure\n" ..
              "  • Tab after '.' for method chaining\n" ..
                             "  • Type '=' for auto-spacing", vim.log.levels.INFO)
end, { desc = "Create IntelliJ IDEA Java style demonstration" })

-- Command to show current Java configuration
vim.api.nvim_create_user_command('ShowJavaConfig', function()
  local config_info = {
    "📋 Java Configuration:",
    "",
    "✅ BASIC INDENTATION:",
    "  • Tab size: " .. vim.bo.tabstop .. " spaces",
    "  • Indent size: " .. vim.bo.shiftwidth .. " spaces", 
    "  • Use spaces: " .. tostring(vim.bo.expandtab),
    "  • Smart indent: " .. tostring(vim.bo.smartindent),
    "",
    "⌨️  COMPLETION & INDENTATION:",
    "  • Tab: Smart Java indentation and completion",
    "  • Shift+Tab: Previous completion item",
    "  • Ctrl+Space: Manual LSP completion",
    "  • Ctrl+X Ctrl+O: Omnifunc completion",
    "",
    "✅ SMART INDENTATION FEATURES (Tab):",
    "  • After '{': Creates bracket structure with 4-space indent",
    "  • After '.': 8-space continuation for method chaining",
    "  • After ',': 8-space parameter continuation", 
    "  • After '&&', '||': 8-space logical continuation",
    "  • Default: 4-space standard indent",
    "",
    "✅ AUTO-SPACING:",
    "  • Assignment operator: space = around = (but not ==, !=, etc.)",
    "  • Format on save: Automatic",
    "  • Manual format: <leader>cf",
    "",
    "💡 TEST COMMANDS:",
    "  • :IntelliJJavaDemo - Test smart indentation and formatting"
  }
  
  for _, line in ipairs(config_info) do
    print(line)
  end
end, { desc = "Show Java configuration" }) 