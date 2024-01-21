I made this repository while studying dbt. Course link [here](https://courses.getdbt.com/courses/take/fundamentals/).

Instead of using the same dataset of the course, I decided to use the pokemon data. It's already available in the `/seeds` folder.

## How to start?

Below you will find the steps teaching how to run the project and some annotations I made while taking the course lessons.

### Dependency

To be able to run this project you will need to have Docker installed in your machine.

### 1. Start the postgres container

`docker compose up postgres -d`

### 2. How to run dbt?

`docker-compose run dbt --rm <command>`

[Commands reference](https://docs.getdbt.com/reference/dbt-commands).

### 3. Populating postgres with the seeds

To load all seeds: `docker compose run --rm dbt seed`

To load just one: `docker compose run --rm dbt seed --select 'raw_artists'`

In case you receive an error because it was not possible to connect to Postgres, try to change the attribute `pokemon.host` to `localhost` inside `profiles.yml`.
For *WSL 2* users it's required to keep the `pokemon.host` as `host.docker.internal`.

### Study Annotations

**Run dbt**

To run only one model:
`docker compose run --rm dbt run --select <model_name>`

Ps.: It only requires the model name without the `.sql` extention.

---

**Configuring materialization**

To configure a model to be materialized as a table instead of a view, it's required to add this config at the top of the model file:
```
{{
    config(
        materialized='table'
    )
}}
```

However, it's also possible to configure it directly on `dbt_project.yml` file.

---

**Seeds usage**

Seeds should not be used to load raw data (for example, large CSV exports from a production database).

Since seeds are version controlled, they are best suited to files that contain business-specific logic, for example a list of country codes or user IDs of employees.

---

**Naming conventions**

> Sources

- the raw data that has already been loaded.

> Staging

- one to one with source tables

> Intermediate

- are the models between staging and final models
- should always be built on staging models

> Fact

- things that are occurring or have occurred.
- events, clicks, votes.

> Dimension

- people, place, user, etc.

---

**Source usage**

It's important to have a source file to configure the staging sources. In case someone need to rename a schema, or something, it's way easier to just change in the source file instead of having to rename it in every staging file.

Ps.: The source name is used as schema name by default. If you have a different schema name, you have to add the attribute in the source file.

---

## TODO

- Transform the seeds in a init.sql script executed by docker-compose when starting up the PostgreSQL container. When executing the init.sql, it should have a column with the current timestamp to be used to check the data freshness. (It's a bad practice to keep huge `.csv` files as seeds. The only file here that makes sense to be a seed in the `raw_cities.csv`.)
- Add tests (I'll address it when taking the next step from the course).