# OVERVIEW

The Unity templates included here add support for showing metadata diffs in much
the same was as the Asset Server interface.  This is achieved by using the 
binary2text program included with Unity, and installing it as a "text converter"
in Git.  A "text converter" is used for showing diffs of binary files in a 
meaningful way, but where such tool cannot be used to actually perform *merges* 
of binary files.

The bin/ directory includes a simple wrapper script around binary2text to make 
it behave in the way Git expects.

# INSTALLATION

You'll want to add the following to ~/.gitconfig in order to fully take 
advantage of the Unity templates:

    [diff "unity"]
        textconv=unity2text

After that, you will want to ensure that the binary2text program included with 
Unity is in your path.

On Mac, the binary2text program can be found in:

    /Applications/Unity/Unity.app/Contents/Tools/

Or, for Unity iPhone users:

    /Applications/Unity iPhone/Unity.app/Contents/Tools/

(Be sure to escape the space with a \ when adding it to your path!)

Either version of the tool will work fine, but I tend to use the one from the 
desktop version of Unity.

Adding binary2text to your path is done in much the same way as adding 
git-template to your path.  Simply add a line like this at the end of .profile:

    export PATH=$PATH:/Applications/Unity/Unity.app/Contents/Tools

Modify as needed based on where Unity is installed.
