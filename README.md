# Student Registry (Beginner)

A classic student/course/enrollment database focused on core relational modeling and SELECT/INSERT/UPDATE/DELETE queries.

## Learning Objectives
- Design an ER model with 1:N and M:N relationships.
- Apply primary keys, foreign keys, unique constraints, and simple indexes.
- Write basic joins and aggregations.
- Practice safe data modifications with constraints.

## Files
- `schema.sql` — Tables and constraints.
- `seed.sql` — Sample data.
- `queries.sql` — 20+ practice queries (with comments).

## Load & Run
```bash
psql -h localhost -p 5432 -U postgres -d playground -f projects/student_registry/schema.sql
psql -h localhost -p 5432 -U postgres -d playground -f projects/student_registry/seed.sql
psql -h localhost -p 5432 -U postgres -d playground -f projects/student_registry/queries.sql
```