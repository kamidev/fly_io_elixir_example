# Fly.io deployment Elixir example

Modified example based on Fly.io [Build, Deploy and Run an Elixir Application](https://fly.io/docs/getting-started/elixir/) documentation plus additional [Elixir guides](https://fly.io/docs/guides/#elixir).

## Before you start

Install [Fly.io CLI](https://fly.io/docs/getting-started/installing-flyctl/). 
Make sure you have a working installation of Erlang and Elixir.


## Get started 

1. Clone this repo
2. Run 'cd hello_elixir'
4. Run 'flyctl launch' - Don’t deploy yet. This generates a new app name in fly.toml, keep that but revert any other changes.
4. Go through the process of [Preparing to Deploy](https://fly.io/docs/getting-started/elixir/#preparing-to-deploy). You need a database to connect to, and the ENV values set for your app, Both for the mix phx.gen.secret and the database connection. 
5. Run 'flyctl deploy'
