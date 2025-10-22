# Conductor Recipe

This recipe demonstrates how to set up a Phoenix application with
[Conductor](https://conductor.build/).

## Overview

Conductor creates isolated development workspaces for agentic coding. This
recipe shows how to configure Phoenix to work seamlessly with Conductor by
meeting three key requirements:

- **Fast setup** - Minimize time to get a workspace running
- **Isolated resources** - Each workspace has its own database and services
- **Fast archive** - Quick teardown of workspace resources

The workspace configuration is defined in `conductor.json`.

### Fast Setup

The `script/worktree` script copies the `deps` and `_build` directories from your main workspace to new workspaces, avoiding the need to rebuild dependencies from scratch.

### Isolated Resources

Each workspace gets its own isolated resources managed via `docker-compose.yml`:

- Docker containers are namespaced using `CONDUCTOR_WORKSPACE_NAME` as the Docker `PROJECT_NAME`
- PostgreSQL database runs on `CONDUCTOR_PORT`
- Phoenix HTTP server runs on `CONDUCTOR_PORT + 1`

This ensures workspaces don't conflict with each other.

### Fast Archive

Since all resources are managed by Docker, tearing down a workspace is as simple as stopping and removing its containers.

## Testing Locally

You can test this setup outside of Conductor to see how it works:

**1. Create and set up a workspace:**

    mkdir -p .conductor
    export CONDUCTOR_WORKSPACE_NAME=workspace_demo CONDUCTOR_PORT=55100
    git worktree add -b demo .conductor/demo develop
    cd .conductor/demo
    script/worktree; script/setup

**2. Run the server** (press Ctrl-C to stop):

    script/server

**3. Clean up the workspace:**

    script/archive
    cd ../..
    unset CONDUCTOR_WORKSPACE_NAME CONDUCTOR_PORT
    git worktree remove .conductor/demo && git branch -D demo
