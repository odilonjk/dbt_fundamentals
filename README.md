I made this repository while studying dbt [here](https://courses.getdbt.com/courses/take/fundamentals/).

### 1. Start the postgres container

`docker compose up postgres -d`

### 2. Running dbt

`docker compose up dbt`

### Study Annotations

To run only one model:
`dbt run --select <model_name>`
Ps.: It only requires the model name without the `.sql` extention.
I still have to check how to use it with `docker compose`.

---

To configure a model to be materialized as a table instead of a view, it's required to add this config at the top of the model file:
```
{{
    config(
        materialized='table'
    )
}}
```

However, it's also possible to configure it directly on `dbt_project.yml` file.