# OVERVIEW

git-template is a tool to provide a somewhat broader templating functionality 
than the one provided with git itself.

Git templates only relate to files in the .git directory, but git-template 
templates can include files throughout the working set.

Additionally, git-template provides some out-of-the-box templates, of particular
note, ones relevant to Unity3D users, XCode users, and MonoDevelop/Visual Studio
users.


# INSTALLATION

Add the git-template/bin directory to your path.  For Mac (and Linux/BSD/etc) 
this can be done by editing the ".profile" file in your home directory.  For 
example, if you installed git-template to ~/Tools/git-template, then you would 
add this line at the end of your .profile:

    export PATH=$PATH:~/Tools/git-template/bin

If you use Unity, see UNITY_README.markdown for further instructions


# REQUIREMENTS

 *  A Unix-like environment, particularly including Bash.
 *  Perl
 *  Rsync

Note that this was developed/tested under MacOS X, which should work fine 
out-of-the-box.  I have not attempted to use this under Cygwin on Windows, but
things should work fine.


# USAGE

    cd /path/to/your/git/repo
    git template --list
    
    ...
    
    git template SomeTemplateName
    
    ...
    
    git template --info
    
    ...
    
    git template --freshen


# LICENSE

Dual licensed under the terms of the MIT X11 or GNU GPL, version 2.0 or newer at
your discretion.


# TODO

 *  More rigorous testing of symlink use-cases.
 *  Ability to specify removal of files (example: existing hook files in hooks 
    directory, for Unity_Desktop template...).
 *  Add git-cleanup script, run it whenever a .gitignore is adjusted.
 *  Way to specify some things, such as .gitignore in terms of lines that 
    must/must not be present.
 *  Less awkward project structure.
 *  Actual test-suite.
 *  Installation instructions.
