# Dusk Neovim

Dusk.nvim is a blazing fast Lua config suited for Full Stack Java development.

## Showcase

<img src="./showcase/dashboard.png" alt="Dashboard" title="Dashboard">
<img src="./showcase/javacode.png" alt="Javacode" title="Javacode">
<img src="./showcase/xmlcode.png" alt="xmlcode" title="xmlcode">

## Design Philosophy

A lot of things have changed in the Neovim world since Dusk's release, near a year ago.
The most important change came recently, with the release of [lazy.nvim](https://github.com/folke/lazy.nvim).

Together with the migration to this package manager, I decided to implement fundamental design changes, which were inspired by the powerful config of [nvimdots](https://github.com/ayamir/nvimdots), which you should definitely check out.

I forked that config and adjusted it to Dusk's design.
I removed unneccesary plugins, made the keymaps much more intuitive, enhanced the functionality for Java development and implemented many ui changes.

The updated design principles of Dusk.nvim are as follows:

- Gotta go fast. Startup and run-time performance are priorities.
- Out-of-the-box complete. Just works with installation.
- Configurable, but advanced code-base. Dusk is not a framework, or a startup config.
- Intuitive, consistent keybinding. f = find, s = search, b = buffer etc.
- Not too opinionated. Striving for sane defaults wherever possible.

## Features

- Native LSP and autocompletion
- Syntax highlighting via nvim-treesitter
- Java code runner with jaq
- Java Unit Testing with vscode-java-test
- Java Debugging via nvim-dap
- Git integration with LazyGit and git-fugitive
- Explore files via nvim-tree
- Fuzzy finder via Telescope
- Notes with Markdown
- Blazing fast performance

## Colorschemes

Supported colorschemes are:

1. Default - [Vscode](https://github.com/Mofiqul/vscode.nvim).
2. [Catpuccin](https://github.com/catppuccin/nvim)
3. [LunarVim Colorschemes](https://github.com/LunarVim/Colorschemes)
4. [Nightfox](https://github.com/EdenEast/nightfox.nvim)

Feel free to add your own colorschemes.
Most colorschemes will be compatible with Dusk.

## Dependencies

For Dusk.nvim to work as intended, you need to have the following dependencies installed:

1. Neovim version >= 0.9.0
2. Git 2.23+
3. Ripgrep for telescope
4. fd for telescope
5. Nodejs
6. Neovim node client (npm install -g neovim) - [neovim/node-client](https://github.com/neovim/node-client)
7. "zig", "clang", or "gcc" executables to be able to compile treesitter parsers (check your package manager for one of these)
8. Treesitter-cli nodejs module (Check your package manager for a treesitter or treesitter-cli package)
9. Java 17+ (for Java LSP server)
10. A font with nerdfont icons (my suggestion: <https://github.com/ryanoasis/nerd-fonts/tree/master/patched-fonts/Hack>)

NOTE: Run :checkhealth command to see what other dependencies you might be missing and to receive help if you have problems with installation.

## Installation

| Platform | Supported |
| :------: | :-------: |
| Windows  |    ❌     |
|  macOS   |    ✅     |
|  Linux   |    ✅     |

1. Make sure to remove or move your current `nvim` directory (`~/.config/nvim`), if it exists.
2. `git clone https://github.com/imbacraft/dusk.nvim`
3. Copy or Move the `nvim` folder from the cloned dusk.nvim project (not the dusk.nvim folder!) to your `~/.config/` folder.
   In the end, your folder should look like this: `~/.config/nvim`. Please note, depending on your OS, neovim might search for configuration in a different folder. In this case, run the `:checkhealth` command inside neovim, to see where it looks for configuration and place the nvim folder inside that.
4. Run the `nvim` command and wait for the plugins to be installed.
5. If some plugins fail to install at this point, don't be alarmed. Enter the `:qa!` command to exit neovim.
6. Re-run the `nvim` command and enter `SPC p s` to update the package manager.
7. Now all the plugins should have been installed. If some have not, run the `:checkhealth` command check the dependencies section above.
8. Ready to go!

## Project structure

```shell
dusk.nvim
├── LICENSE
├── README.md
└── nvim
    ├── ftplugin
    │   └── java.lua
    ├── init.lua
    ├── jars
    │   ├── java-debug
    │   │   └── com.microsoft.java.debug.plugin-0.44.0.jar
    │   └── vscode-java-test
    └── lua
        ├── core
        │   ├── autocommands.lua
        │   ├── global.lua
        │   ├── init.lua
        │   ├── options.lua
        │   ├── pack.lua
        │   └── settings.lua
        ├── keymaps
        │   ├── init.lua
        │   └── which-key.lua
        └── modules
            ├── configs
            │   ├── completion
            │   ├── editor
            │   ├── lang
            │   ├── tool
            │   └── ui
            ├── plugins
            │   ├── completion.lua
            │   ├── editor.lua
            │   ├── lang.lua
            │   ├── tool.lua
            │   └── ui.lua
            └── utils
                ├── functions.lua
                ├── icons.lua
                └── init.lua
```

## Java Debugging and Testing

The jars required for Java debugging and testing are included in the jars folder.
However, if you want to build them yourself from source, do the following:

1. For Java Debug Plugin:

```
git clone https://github.com/microsoft/java-debug
cd java-debug/
./mvnw clean install
```

2. For Java Testing:

```
git clone https://github.com/Microsoft/vscode-java-test
cd vscode-java-test
npm install
npm run build-plugin
```

## Java Multiple Runtimes

In the file ftplugin/java.lua, you can setup your Java runtimes.
The commented code for the runtimes is my own configuration.
Feel free to adjust it to your preferences.

Here is the excerpt from ftplugin/java.lua with my own configuration:

```lua
configuration = {
    updateBuildConfiguration = "interactive",
    -- runtimes = {
    --  {
    --   name = "JavaSE-1.8",
    --   path = "/Library/Java/JavaVirtualMachines/zulu-8.jdk/Contents/Home",
    --  },
    --  {
    --   name = "JavaSE-1.8",
    --   path = "/Library/Java/JavaVirtualMachines/jdk1.8.0_291.jdk/Contents/Home",
    --  },
    --  {
    --   name = "JavaSE-11",
    --   path = "/opt/homebrew/Cellar/openjdk@11/11.0.18/libexec/openjdk.jdk/Contents/Home",
    --  },
    --  {
    --   name = "JavaSE-19",
    --   path = "/opt/homebrew/Cellar/openjdk/19.0.2/libexec/openjdk.jdk/Contents/Home",
    --  },
    -- },
                }

```
