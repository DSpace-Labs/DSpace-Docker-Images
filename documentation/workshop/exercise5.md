{% include nav.wkshop.html %}
# Exercise 5: Advanced Topics

If this workshop inspires you to contribute code to DSpace, please see the following [Git Instructions on the DSpace Wiki](https://wiki.duraspace.org/display/DSPACE/Development+with+Git).

### Clone the DSpace Code Base to your Desktop

In a __new terminal__ run the following command to get a copy of the DSpace code.  The exercies will refer to this as your __code terminal__.

```
cd
git clone https://github.com/DSpace/DSpace.git
cd DSpace
```

### Test a code change to DSpace 6

The following links recommend a change that is easy to verify
- [XMLUI PR](https://github.com/DSpace/DSpace/pull/2431)
- [Code Diff of PR](dspace.2431.diff)

In your __code terminal__, switch to the DSpace 6 Branch
```
git checkout dspace-6_x
git pull
```

Create a branch for your changes
```
git checkout -b my6xChange
```

Using a text editor or code editor, modify the files as shown in the pull request link above.  If you do not have a good editor, you can run the following.

```
git apply ~/DSpace-Docker-Images/documentation/workshop/dspace.2431.diff
```

You can view the changes that were applied with the following command.

```
git diff
```

The following get the path to find your source code.

```
pwd
```

Copy this pathname.

Return to the terminal where you have been running docker commands.  In that terminal, run the following command.

```
export DSPACE_SRC=<<path listed above>>
```

Check to see if DSpace is already running.  If so, stop your instance.

```
docker ps
```

Run the following command to build you DSpace code.

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f src.override.yml build
```

Once the build is done, run the following to start Docker with the code you built.

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f src.override.yml up -d
```

Verify your changes in [XMLUI](http://localhost:8080/xmlui).

Once you are done, stop DSpace

```
docker-compose -p d6 -f docker-compose.yml -f d6.override.yml -f src.override.yml down
```

### Test a code change to DSpace 7

The following links recommend a change that is easy to verify
- [REST API PR](https://github.com/DSpace/DSpace/pull/2436)
- [Code Diff of PR](dspace.2436.diff)

In your __code terminal__, discard your prior changes.

```
git stash
```

Switch to the DSpace 7 (master) Branch
```
git checkout master
git pull
```

Create a branch for your changes
```
git checkout -b my7xChange
```

Using a text editor or code editor, modify the files as shown in the pull request link above.  If you do not have a good editor, you can run the following.

```
git apply ~/DSpace-Docker-Images/documentation/workshop/dspace.2436.diff
```

You can view the changes that were applied with the following command.

```
git diff
```

The following get the path to find your source code.

```
pwd
```

Copy this pathname.

Return to the terminal where you have been running docker commands.  In that terminal, run the following command.

```
export DSPACE_SRC=<<path listed above>>
```

Check to see if DSpace is already running.  If so, stop your instance.

```
docker ps
```

Run the following command to build you DSpace code.

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f src.override.yml build
```

Once the build is done, run the following to start Docker with the code you built.

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f src.override.yml up -d
```

Verify your changes in the [HAL Browser](http://localhost:8080/spring-rest).

Once you are done, stop DSpace

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f src.override.yml down
```
### Test a code change to DSpace 7 Angular

The following links recommend a change that is easy to verify
- [REST API PR](https://github.com/DSpace/DSpace-angular/pull/406)
- [Code Diff of PR](dspace-angular.406.diff)

In your __code terminal__, discard your prior changes.

```
git stash
```

Clone the DSpace-angular code to your desktop.

```
cd
git clone https://github.com/DSpace/DSpace-angular.git
cd DSpace-angular
```


Create a branch for your changes
```
git checkout -b my7xChange
```

Using a text editor or code editor, modify the files as shown in the pull request link above.  If you do not have a good editor, you can run the following.

```
git apply ~/DSpace-Docker-Images/documentation/workshop/dspace-angular.406.diff
```

You can view the changes that were applied with the following command.

```
git diff
```

The following get the path to find your source code.

```
pwd
```

Copy this pathname.

Return to the terminal where you have been running docker commands.  In that terminal, run the following command.

```
export ANGULAR_SRC=<<path listed above>>
```

Check to see if DSpace is already running.  If so, stop your instance.

```
docker ps
```

Run the following command to build you DSpace code.

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f ang-src.override.yml build
```

Once the build is done, run the following to start Docker with the code you built.

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f ang-src.override.yml up -d
```

Verify your changes in the Angular UI.

Once you are done, stop DSpace

```
docker-compose -p d7 -f docker-compose.yml -f d7.override.yml -f ang-src.override.yml down
```
