# Fly.io deployment Elixir example

Modified example based on Fly.io [Build, Deploy and Run an Elixir Application](https://fly.io/docs/getting-started/elixir/) documentation plus additional [Elixir guides](https://fly.io/docs/guides/#elixir). 

## Before you start

Install [Fly.io CLI](https://fly.io/docs/getting-started/installing-flyctl/). 

Make sure you have a working installation of Erlang and Elixir. 
Using [asdf to install Erlang and Elixir](https://thinkingelixir.com/install-elixir-using-asdf/) is an easy way.  

[direnv](https://direnv.net/) is a nice but optional tool for keeping track of local environment variables. 


## Get started 

1. Clone this repo
2. Run 'cd hello_elixir'
4. Run 'flyctl launch' - but don’t deploy yet, this generates a new app name in fly.toml. Keep the name and revert any other changes.
4. Go through the process of [Preparing to Deploy](https://fly.io/docs/getting-started/elixir/#preparing-to-deploy). You need a database to connect to and must set some ENV values for your app. 
6. Run 'flyctl deploy'
