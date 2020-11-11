<div align="center">
  <span align="center"> <img width="80" height="80" class="center" src="data/icons/com.github.manexim.emoji-art.svg" alt="Icon"></span>
  <h1 align="center">Emoji Art</h1>
  <h3 align="center"></h3>
  <p align="center">Designed for <a href="https://elementary.io">elementary OS</a></p>
</div>

<p align="center">
  <a href="https://travis-ci.org/manexim/emoji-art">
    <img src="https://img.shields.io/travis/manexim/emoji-art.svg">
  </a>
  <a href="https://github.com/manexim/emoji-art/releases/">
    <img src="https://img.shields.io/github/release/manexim/emoji-art.svg">
  </a>
  <a href="https://github.com/manexim/emoji-art/blob/master/COPYING">
    <img src="https://img.shields.io/github/license/manexim/emoji-art.svg">
  </a>
</p>

## Installation

### Dependencies

These dependencies must be present before building:

-   `meson`
-   `ninja`
-   `valac`
-   `libgtk-3-dev`
-   `libgranite-dev`

### Building

```
git clone https://github.com/manexim/emoji-art.git && cd emoji-art
meson build --prefix=/usr && cd build
ninja
sudo ninja install
com.github.manexim.emoji-art
```

### Deconstruct

```
sudo ninja uninstall
```

## Contributing

If you want to contribute to emoji-art and make it better, your help is very welcome.

### How to make a clean pull request

-   Create a personal fork of this project on GitHub.
-   Clone the fork on your local machine. Your remote repo on GitHub is called `origin`.
-   Create a new branch to work on. Branch from `master`!
-   Implement/fix your feature.
-   Push your branch to your fork on GitHub, the remote `origin`.
-   From your fork open a pull request in the correct branch. Target the `master` branch!

And last but not least: Always write your commit messages in the present tense.
Your commit message should describe what the commit, when applied, does to the code – not what you did to the code.

## License

This project is licensed under the GNU General Public License v3.0 - see the [COPYING](COPYING) file for details.
