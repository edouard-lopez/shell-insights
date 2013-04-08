# shell-insights

`shell-insights` is a **business intelligence utility** that provide **visual insights** to your shell practices, as well as the one of your team.

## Description

1. It uses `Bash` and `AWK` for the back-end processing of extracting your data from your shell history. The following shells are available:
    * `zsh`,
    * `bash` *todo*,
    * `csh` *todo*,
    * `ksh` *todo*,
    * `sh` *todo*,
    * `tsh` *todo*,
    * etc.
2. and [`d3.js`](http://d3js.org/) library to visualize.

## Screenshots

## Requirement

* [yeoman](http://yeoman.io/): a collection of tools and best practices working in harmony to make developing for the web even better.
* [jshon](https://github.com/keenerd/jshon/): Jshon parses, reads and creates `JSON` ;


## Installation

1. First fetch the project and the dependencies

    ```
    git clone git@github.com:edouard-lopez/shell-insights.git
    git submodule add git://github.com/keenerd/jshon.git
    git submodule init
    ```

2. Then build `jshon` executable:

    ```
    cd ./jshon/
    make
    ```

## Usage

1. Run the history collector:

    ```
    cd .. # back to project directory
    bash ./shell-insights.bash
    ```
2. Start your server using `grunt` and visualize data:

    ```
    grunt server
    # open the app on your default browser
    ```
