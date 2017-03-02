[npm][01] is the package manager for [Node.js][04]
(and javascripts, angular, io.js, nodebots, jquery, grunt, etc.).
The npm command-line tool is bundled with node and io.js.
If you have either of those installed, then you already have npm too.

[npm's documentation site][02] featuring large number of videos and tutorial.



# Node Package Manager (npm)
* [A Beginner’s Guide to npm — the Node Package Manager](http://www.sitepoint.com/beginners-guide-node-package-manager/)
* [npm cheat sheet](http://browsenpm.org/help)
* [10 Cool Things You Probably Didn’t Realize npm Could Do](http://blog.izs.me/post/1675072029/10-cool-things-you-probably-didnt-realize-npm)

```bash
# initial install of npm
sudo apt-get install npm

# update the npm package
 sudo npm install npm -g
```

# Starting a Node.js Project
[Getting a new node project started with npm][05]

```bash
# create your project directory
mkdir npmtest

# change to the directory you just created and establish git repository
cd !$
git init

# pull preconfigured .gitignore file
wget https://gist.github.com/jeffskinnerbox/9612119 -O .gitignore

# initialise your node.js and create your project.json
npm init
```

```bash
# Once you have added some code to index.js and some tests of course, add and commit your code.
git add .
git commit -a 'Initial release'

# Now your ready to release use npm to update the version. There are three options for this command being major, minor and patch each of which increments the version numbers in that order. In the example below we should go from 0.0.0 to 0.1.0.
npm version minor

# Run your tests!
npm test

# Push to github, the version command automatically tags your project so we can check it out if we need!
git push origin master --tags

# Ship it
npm publish
```

Other Nifty Commands

```bash
# creates a package.json in root for you
npm init

# lists all installed packages
npm list

# removes packages not depended on by your project according to your package.json
npm prune

# tells you which installed packages are outdated with respect to what is current
# in the npm registry but allowable by the version definition in your package.json
npm outdated
```

# Properties of package.json
The `package.json` file provides you several useful things:

* It serves as documentation for what packages your project depends on.
* It allows you to specify the versions of a package that your project can use using semantic versioning rules.
* Makes your build reproducable which means that its way easier to share with other developers.

The [package.json interactive guide][03] describes important properties
of the package.json packaging format for node.js applications.

`npm init` will create a `package.json` file using a default format.
It is also possible to totally customize the information created
and the questions asked during the init process.
This is done by creating a custom `.npm-init.js`,
or it will use the default `~/.npm-init.js`.

A simple `.npm-init.js` could look something like this:

```json
module.exports = {
  customField: 'Custom Field',
  otherCustomField: 'This field is really cool'
}
```

Running `npm init` with this file in your home directory,
would output a `package.json` similar to this:

```json
{
  customField: 'Custom Field',
  otherCustomField: 'This field is really cool'
}
```

Customizing the questions is also possible, by using the prompt function.

```json
module.exports = prompt("what's your favorite flavor of ice cream buddy?", "I LIKE THEM ALL");
```

To learn more on how to create more advanced customizations,
checkout "[Specifics of npm's package.json handling][06]".

Sometime you can forget to use the `--save` flag when installing new modules.
As a result, your `package.json` file will not be updated with dependencies.
To discover those dependencies after this mishap,
you can create a [script to collect the dependencies][07] in `./node_modules`,
or use the `npm-collect` module.

```bash
# install npm-collect
sudo npm install -g npm-collect

# print out your projects module dependencies
nmp-collect

# update your package.json with your projects module dependencies
nmp-collect --save
```

Editing your  `package.json` file could introduce errors.
To validate your edits, you can use the [Package.json validator][08].



[01]:https://www.npmjs.com/
[02]:https://docs.npmjs.com/
[03]:http://browsenpm.org/package.json
[04]:https://nodejs.org/en/
[05]:http://www.wolfe.id.au/2014/02/01/getting-a-new-node-project-started-with-npm/
[06]:https://docs.npmjs.com/files/package.json
[07]:http://stackoverflow.com/questions/9961502/is-there-a-way-to-automatically-build-the-package-json-file-for-node-js-projects
[08]:http://package-json-validator.com/
[09]:
[10]:
