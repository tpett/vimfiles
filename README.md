Tpett's vim configuration
=========================

Thanks to these guys:

* [Gary Bernhardt](http://destroyallsoftware.com),
* [Drew Neil](http://vimcasts.org),
* [Tim Pope](http://tbaggery.com),
* [Mislav](http://mislav.uniqpath.com/),
* and the [Janus project](https://github.com/carlhuda/janus).

My configuration uses [Vundle](https://github.com/gmarik/vundle) to
manage plugins.

## Plugins

All plugins are listed in
[my vimrc file](https://github.com/tpett/vimfiles/blob/master/vimrc).
Check it out if you want to learn more about my configuration.

### Installation

If you would like to check out my configuration I would highly recommend
forking your own copy to make it easy to change in the future.

Setup is handled through Rake. Ruby and wget are required. Only works
for OS X.

    # If you have an existing .vim folder
    $ mv ~/.vim ~/.vim.old

    $ git clone https://github.com/tpett/vimfiles.git ~/.vim
    $ cd ~/.vim && rake setup

