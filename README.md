# Travis CI x Kiuwan Integration 

![143135305-bbab7c88-7a27-4e51-9453-623012b8d2fc](https://user-images.githubusercontent.com/20936398/144514977-2e359cda-1528-4eb4-a24f-5f61f1926c86.png)


## Usage

This is an integration between Travis and Kiuwan, there's a lot of moving objects to this - some declarative. What I've done is try to make the `.travis.yml` as simple as possible as this is the first time I personally know this has been done.

## The process

In Travis, I told Travis to fetch the Local Analyzer, then went through Kiuwan's LA's documentation to make a command that checks the project. This project in particular is in TypeScript, below I'll share the `.travis.yml` file I've created: 

```yaml
language: java
install: skip

script:
  - echo $TRAVIS_BUILD_DIR
  - export APPNAME=$(basename $TRAVIS_BUILD_DIR)
  - export BRANCH=$(if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then echo $TRAVIS_BRANCH; else echo $TRAVIS_PULL_REQUEST_BRANCH; fi)
  - echo "Fetching Kiuwan Local Analyzer
  - wget -v https://www.kiuwan.com/pub/analyzer/KiuwanLocalAnalyzer.zip
  - unzip KiuwanLocalAnalyzer.zip -d $HOME/.
  - $HOME/KiuwanLocalAnalyzer/bin/agent.sh --user $kiuwan_user --pass $kiuwan_password -s $TRAVIS_BUILD_DIR -n $APPNAME -l $TRAVIS_BUILD_ID -c
  ```
  
This then sends this to Kiuwan, and from there I can access more insights about my project. In this project in particular I made this have a few vulnerabilities so Kiuwan would catch them. I also used `environment variables` from my account I registered from the `Jelly` service. 

## Bash Script 

Michal Rybinski and I earlier in this day had a conversation about theoretical ways in this could work, where all attempts (at least on GitHub) have failed, so what I did was make a pretty standard `.travis.yml` make it declarative, I'm now working on a bash script where you can just run the following:

```bash
chmod u+x kiuwan.sh
```
We are changing the permission using `chmod` then running `kiuwan.sh` which takes all the steps I set the `.travis.yml` to do, and put that under the Travis `script` hook.

## Conclusion 

This is a working example/demo of Kiuwan and Travis CI working together, although there's moving parts and I had to make the project more declarative using TypeScript instead of something like vanilla JavaScript I still was able with reading the Travis CI PRD provided by Michal Rybinski & Stan, make a simple integration between Travis and Kiuwan.
