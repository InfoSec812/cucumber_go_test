# Overview

A simple example to scaffold a Ruby Cucumber test project

# Usage

```bash
git clone git@gitlab.com:mcc-labs/example-oc-cucumber-test.git
cd example-oc-cucumber-test
bundler install --path=GEMS
export PATH=${PATH}:${PWD}/GEMS/ruby/2.5.0/bin
mkdir reports

cucumber -f html -o reports/index.html     ## Run cucumber test
```

# Recreating this

[Reference](https://docs.cucumber.io/guides/10-minute-tutorial/)

```bash
## Install ruby and bundler, or have them pre-installed in a container image (like jenkins-slave-ruby)

mkdir my-new-cucumber-project
cd my-new-cucumber-project

## Create Gemfile

bundler install --path=GEMS
export PATH=${PATH}:${PWD}/GEMS/ruby/2.5.0/bin
cucumber --init

## Create feature file in features/ directory

## Implement steps in features/step_definitions

## Run cucumber
cucumber
```