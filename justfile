# Bash options to run before scripts.
opts := '-eu pipefail'
shopts := 'extglob globstar'
set shell := [
    'bash',
    '-o', 'errexit',
    '-o', 'nounset',
    '-o', 'pipefail',
    '-O', 'extglob',
    '-O', 'globstar',
    '-c',
]

# Project name.
proj := 'miracia'
# Content directory containing web files.
content := '.'
# Directory to deploy production files to.
dist := 'dist'
# Branch to push production files to.
dist-branch := 'gh-pages'

# The `just` executable.
just :=  just_executable()

# Run NPM binaries.
npm_exec := 'pnpm exec'
# HTTP Server.
http_server := npm_exec + ' http-server'
# Parcel.
parcel := npm_exec + ' parcel'
# Parcel error workaround.
export NODE_OPTIONS := '--no-experimental-fetch'
# Prettier.
prettier := npm_exec + ' prettier'

# Command to run to install Racket packages.
raco_install := 'raco pkg install --auto --no-docs --skip-installed'
# Racket dependencies.
racket_deps := 'counter hyphenate pollen'
racket_dev_deps := 'fmt'


# Build the project by default.
default: build-dev

alias build := build-dev
# Run a development build of the project.
build-dev: (_build-pollen '--no-optimize')
# Run a production build of the project.
build-prod: (_build-pollen-rkt '')

# Rebuild pollen Racket files.
_build-pollen-rkt parcel_flags='': clean && (_build-pollen parcel_flags)
# Build pollen sources.
_build-pollen parcel_flags='': && (_build-parcel parcel_flags)
    raco pollen render --parallel pm
# Build parcel sources.
_build-parcel parcel_flags='':
    {{parcel}} build \
        --no-source-maps \
        {{parcel_flags}}

# Install packages and create initial build.
start: install _build-pollen-rkt


# Watch for changes to rebuild the project.
watch:
    watchexec --clear --exts ptree,rkt just _build-pollen-rkt & \
        watchexec --clear --exts p,pp,pm just _build-pollen & \
        watchexec --clear --exts html,less,mjs,p,pm,ptree,ts just _build-parcel

# Serve the project.
serve dir=dist port='8080':
    exec {{http_server}} \
        --silent --port {{port}} {{quote(dist)}}


# Deploy the project.
deploy: install tidy build-prod && clean
    git add .
    git stash push
    git add --force {{quote(dist / proj)}}
    git commit --allow-empty-message --message ''
    git subtree split --prefix {{quote(dist / proj)}} --branch {{dist-branch}}
    git push --force origin {{dist-branch}}:{{dist-branch}}
    git reset HEAD~
    git branch -D {{dist-branch}}
    git stash pop

# Clean up build artifacts.
clean:
    fd -e zo -x rm {}
    raco pollen reset
    fd '' -Ie html pm/ --exec rm {}
    rm -rf .parcel-cache

# Clean build artifacts and remove `dist` directory.
tidy: clean
    rm -rf {{quote(dist)}}/!(.keep)
    touch dist/.keep

# Reset all repository artifacts.
reset: tidy
    rm -rf node_modules

# Recursively remove build artifacts.
_clean target=content:
    #! /usr/bin/env bash
    set {{opts}} ; shopt -s {{shopts}}
    [[ $(git check-ignore "{{target}}") ]] && exit
    echo "clean {{target}}"
    for i in "{{target}}"/* ; do
        if [[ -d "$i" ]] ; then
            {{just}} _clean "$i"
        elif [[ -f "$i" ]] && [[
            (-f "$i".p || -f "$i".pp || -f "$i".pm || -f "${i%.*}".poly.pm) ||
            ("$i" =~ .*\.css && (-f "${i%.*}.less"))
        ]] ; then
            echo "rm $i"
            rm "$i"
        fi
    done

# Install packages required for the project.
install: (_cmd_exists 'raco') (_cmd_exists 'fmt')
    # Racket: Required dependencies.
    {{raco_install}} {{racket_deps}}
    # Racket: Development dependencies.
    {{raco_install}} {{racket_dev_deps}}
    raco setup --pause
    pnpm install

# Format sources.
format:
    raco fmt -i "{{content}}"/**/*.rkt
    {{prettier}} --no-error-on-unmatched-pattern --write "{{content}}"/{css,js}
    {{prettier}} --no-error-on-unmatched-pattern --write --parser html \
        "{{content}}"/**/*.html.p
alias fmt := format

# Check that a command exists before running.
_cmd_exists cmd:
    command -v "{{cmd}}" > /dev/null # Check that `{{cmd}}` is available.
