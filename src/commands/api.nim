import os
import sugar
import tables
import strformat
import sequtils
import fab
import docopt
import progress





# MVC folder
let mvcDir = @["src/models", "src/routes", "src/controllers"]
let testDir = @[&"tests"]
let allDirs = mvcDir & testDir




let nimbleFile = () => writeFile(
"app.nimble",
"""
# Package
version       = "1.0.3"
author        = "Adeoluwa Adejumo"
description   = "Sample Web App"
license       = "MIT"
srcDir        = "src"
binDir        = "bin"
bin           = @["app"]
# Dependencies
requires "nim >= 1.0.2", "jester", "norm >= 1.0.16", "dotenv >= 1.1.1"
# Tasks
task createdb, "Create DB tables from user defined types":
  exec "nim c -r src/models/models.nim"
  rmFile "src/models/models".toExe()
"""
)


let splitRoute = () => writeFile(
"src/app.nim",
"""
import jester
import routes/api

routes:
  extend endPoints, "/api"
    
runForever()
"""
)


let sampleRoute = () => writeFile(
"src/routes/api.nim",
"""
import jester
#import "../models/<your-model>.nim"

router endPoints:
  # get user details
  get "/user":
    resp "works"
  
  # create a new user
  post "/user/new":
    resp "works"
 
 # get product details
  get "/product/":
    resp "works"
"""
)


let readMe = () => writeFile(
"README.md",
"""
# Project Name
<!-- Don't forget to add your badges (License, CI, Code coverage) -->
Project name is a <utility/tool/feature> that allows <insert_target_audience> to do <action/task_it_does>.
<!-- GIF Demo / Screenshot here -->
Additional line of information text about what the project does. Your introduction should be around 2 or 3 sentences. Don't go overboard, people won't read it.
## Features
[x] Feature 1
[x] Feature 2 
[ ] Feature 3
## Installation
Use the package manager [nimble](https://pip.pypa.io/en/stable/) to install foobar.
```bash
nimble install foobar
```
## Usage
```nim
import foobar
foobar.pluralize('word') # returns 'words'
foobar.pluralize('goose') # returns 'geese'
foobar.singularize('phenomena') # returns 'phenomenon'
```
## Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.
## Contact
twitter: @nobody
wechat: xyz
## License
[MIT](https://choosealicense.com/licenses/mit/)
"""
)


proc runApp() = discard execShellCmd "nimble run app"


#let feedBack = () => ""








proc genAPI*(args: Table[system.string, docopt.Value]) =
  for api in @(args["<api>"]):

    blue(&"Generating API structure for {api}...")

    # start new progress bar
    var bar = newProgressBar()
    bar.start()
   
    # create directories
    for eachDir in allDirs:
      createDir &"{api}/{eachDir}"
     
    
    for i in 1..100:  
      sleep(30)
      bar.increment()
    bar.finish()
    
    
    setCurrentDir(&"{api}")
    nimbleFile() 
    splitRoute()
    sampleRoute()
    readMe()
    runApp()
    #feedBack()
