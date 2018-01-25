#!/bin/bash

################################################################################
###                     Git Client Global Configuration                      ###
################################################################################
#            Source code at https://github.com/arthurbeggs/scripts             #
################################################################################
#                                                                              #
#     This script assumes:                                                     #
#       - You use Meld as your diff and merge tool;                            #
#       - You use GPG keys to sign your commits and tags;                      #
#       - You use nano as your default CLI editor.                             #
#                                                                              #
#     You can find more information about GPG signing in the following link:   #
# https://help.github.com/articles/signing-commits-with-gpg/                   #
#                                                                              #
#     Feel free to copy and modify this file. Giving me credit for it is your  #
# choice, but please keep references to other people's work, which I don't     #
# have ownership and thus cannot decide what to do with the licenses.          #
#                                                                              #
################################################################################

echo "Git Global Configuration"
echo \\n'This script assumes you have a GPG signing key already set and knows your key ID!'
echo \\n'Press any key to continue or [^C] to abort.'
read -n 1 keypress

read -p "Your name: "  username
read -p "Your email: " useremail
read -p "Your GPG key ID" keyid

git config --global user.name  "$username"
git config --global user.email "$useremail"


# TODO: Complete other OSes configuration
case "$OSTYPE" in

    linux*)

        echo "Operational system identified as [linux]"

        git config --global core.autocrlf input
        echo "[autocrlf] Set as \"input\""

        echo "Compiling git-credential-libsecret [needs sudo]..."
        sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret

        git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
        echo "Password caching [active]!"

        git config --global core.editor nano
        echo "Default text editor set as [nano]!"

        git config --global merge.tool meld
        # git config --global mergetool.meld.cmd 'meld "$LOCAL" "$BASE" "$REMOTE" --output "$MERGED"'
        git config --global mergetool.meld.cmd 'meld "$LOCAL" "$MERGED" "$REMOTE" --output "$MERGED"'
        echo "Default merge tool set as [meld]!"

        git config --global diff.tool meld
        git config --global difftool.prompt false
        git config --global difftool.meld.cmd 'meld "$LOCAL" "$REMOTE"'
        echo "Default diff tool set as [meld]!"

        echo "Configuring automatic GPG signing:"
        git config --global user.signingKey $keyid
        git config --global tag.forceSignAnnotated true
        git config --global commit.gpgSign true
        git config --global gpg.program gpg2
        echo "GPG signing configured!"
        ;;

    darwin*)
        echo "Operational system identified as [OSX]"

        echo "Autocrlf set as [input]!"
        git config --global core.autocrlf input

        echo "Password caching [active]!"
        git config --global credential.helper osxkeychain
        ;;

    msys*)
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        echo "Operational system identified as [Windows]"

        echo "Autocrlf set as [true]!"
        git config --global core.autocrlf true

        echo "Password caching [active]!"
        git config --global credential.helper wincred
        ;;

    cygwin*)
        # POSIX compatibility layer and Linux environment emulation for Windows
        echo "Operational system identified as [Windows]"

        echo "Autocrlf set as [true]!"
        git config --global core.autocrlf true

        echo "Password caching [active]!"
        git config --global credential.helper wincred
        ;;

    win32*)
        # I'm not sure this can happen.
        echo "Operational system identified as [Windows]"

        echo "Autocrlf set as [true]!"
        git config --global core.autocrlf true

        echo "Password caching [active]!"
        git config --global credential.helper wincred
        ;;

    *)
        echo "Operational system undentified. Treating as [linux]"

        git config --global core.autocrlf input
        echo "[autocrlf] Set as \"input\""

        echo "Compiling git-credential-libsecret [needs sudo]..."
        sudo make --directory=/usr/share/doc/git/contrib/credential/libsecret

        git config --global credential.helper /usr/share/doc/git/contrib/credential/libsecret/git-credential-libsecret
        echo "Password caching [active]!"

        git config --global core.editor nano
        echo "Default text editor set as [nano]!"

        git config --global merge.tool meld
        # git config --global mergetool.meld.cmd 'meld "$LOCAL" "$BASE" "$REMOTE" --output "$MERGED"'
        git config --global mergetool.meld.cmd 'meld "$LOCAL" "$MERGED" "$REMOTE" --output "$MERGED"'
        echo "Default merge tool set as [meld]!"

        git config --global diff.tool meld
        git config --global difftool.prompt false
        git config --global difftool.meld.cmd 'meld "$LOCAL" "$REMOTE"'
        echo "Default diff tool set as [meld]!"

        echo "Configuring automatic GPG signing:"
        git config --global user.signingKey $keyid
        git config --global tag.forceSignAnnotated true
        git config --global commit.gpgSign true
        git config --global gpg.program gpg2
        echo "GPG signing configured!"
        ;;

esac

echo \\n'Check if your configurations are correct:'
echo \\n
git config --list

