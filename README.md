<div align="center">
  <h1 align="center">Fnvim</h1> 
	<a href="https://github.com/quocnho/fnvim/#features">✨ Features</a>
  <span> • </span>
	<a href="https://github.com/quocnho/fnvim/#installation">📦 Installation</a>
  <span> • </span>
	<a href="https://github.com/quocnho/fnvim/wiki">📚 Wiki</a>
  <span> • </span>
	<a href="https://github.com/quocnho/fnvim/wiki/Screenshots">📷 Screenshots</a>
  <span> • </span>
    <a href="https://github.com/quocnho/fnvim/releases/latest">
      <img alt="Latest release" src="https://img.shields.io/github/v/release/quocnho/fnvim?style=for-the-badge&logo=starship&color=C9CBFF&logoColor=D9E0EE&labelColor=302D41&include_prerelease&sort=semver" />
    </a>
  <span> • </span>
    <a href="https://github.com/quocnho/fnvim/pulse">
      <img alt="Last commit" src="https://img.shields.io/github/last-commit/quocnho/fnvim?style=for-the-badge&logo=starship&color=8bd5ca&logoColor=D9E0EE&labelColor=302D41"/>
    </a>
  <span> • </span>
    <a href="https://github.com/quocnho/fnvim/stargazers">
      <img alt="Stars" src="https://img.shields.io/github/stars/quocnho/fnvim?style=for-the-badge&logo=starship&color=c69ff5&logoColor=D9E0EE&labelColor=302D41" />
    </a>
  <span> • </span>
    <a href="https://github.com/quocnho/fnvim/issues">
      <img alt="Issues" src="https://img.shields.io/github/issues/quocnho/fnvim?style=for-the-badge&logo=bilibili&color=F5E0DC&logoColor=D9E0EE&labelColor=302D41" />
    </a>
  <p></p>
</div>

![fnvim Image](https://raw.githubusercontent.com/quocnho/fnvim/main/assets/screenshot.png)

## Introduction

The goal of this project is to simply _get work done_ quickly.

Fnvim is a blazing fast Lua config suited for Full Stack Golang, JS and Java development.
This project is built to be:

- **Functional**. The core of an ideal IDE is functionality. If there is anything you want to add, please consider contributing
- **Minimal**. fnvim gives you what you need. Not too much, not too less.
- **Fast**. fnvim loads as smooth as butter with an optimum amount of plugins and lazy loading.
- **Easy to Configure**. If there's anything extra that you want to add or something you'd like to tweak, fnvim has an awesome [configuration system](https://github.com/quocnho/fnvim/wiki/User-Configuration) built in.

## Showcase

<img src="./showcase/dashboard.png" alt="Dashboard" title="Dashboard">
<img src="./showcase/javacode.png" alt="Javacode" title="Javacode">
<img src="./showcase/xmlcode.png" alt="xmlcode" title="xmlcode">
## Features

- Easy to install and use
- Written in an efficient programming language
- Extensible package management system
- Very elegant and clean look
- Beautiful syntax highlighting with treesitter
- Language support and Code Autocompletion
- Great support for version control
- Terminal integration
- Efficient file navigation
- Autoformatting
- Awesome user configuration system
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

## Requirements

- [Neovim Version > 0.5](https://github.com/neovim/neovim/releases/tag/v0.5.0) - Required - For lua configuration
- [NodeJS](https://nodejs.org) - Required - For LSP
- [Lazygit](https://github.com/jesseduffield/lazygit) - Optional - For git integration
- [RipGrep](https://github.com/BurntSushi/ripgrep) - Optional - For telescope live grep

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

Make sure you have curl and bash installed before you run this script.

```bash
curl -s https://raw.githubusercontent.com/quocnho/fnvim/main/install.sh | bash -s
```

## Manual Installation

```
git clone https://github.com/quocnho/fnvim ~/.config/nvim
nvim
```

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

## After Installation

You almost certainly want to add some plugins of your own. You can do it by making your own [config file](https://github.com/quocnho/fnvim/wiki/User-Configuration)
Please read the [wiki](https://github.com/fnvim/fnvim/wiki) for [Keybindings](https://github.com/quocnho/fnvim/wiki/Keybindings), [Language Servers](https://github.com/quocnho/fnvim/wiki/Language-Servers), [Plugins](https://github.com/quocnho/fnvim/wiki/Plugins) and [Screenshots](https://github.com/quocnho/fnvim/wiki/Screenshots).
After making fnvim your own, consider posting some screenshots [here](https://github.com/quocnho/fnvim/issues/20).

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.

## License

This project is licensed under the GPL-3.0 license.
