# SqueezeStack DB

> A clean, queryable foundation for juices, sandwiches, ingredients, nutrition estimates, and practical everyday meal ideas.

**Status:** schema-first prototype · **Maintainer:** [V. Dixon](https://github.com/Vewiser) · **Track:** VisionWell × VisionFlow

## Why it exists

Everyday recipes are usually scattered across notes, videos, screenshots, and ingredient lists. SqueezeStack turns that information into structured data that can support a juice-and-sandwich library, shopping tools, cost estimates, dashboards, and—later—responsible recommendation experiments.

## Honest scope

This repository currently defines the data product and its first schema. It is not yet a deployed nutrition or medical application. Nutrition values are estimates and must be traceable to a named source. Nothing here diagnoses, treats, or prevents disease.

## MVP questions

- Which recipes can be made from ingredients already on hand?
- Is this recipe a juice or sandwich?
- What is the estimated cost per serving?
- Which allergens or user-excluded ingredients appear?
- How do ingredients, color, flavor, and preparation time compare?
- Which recipes are actually repeated, rated, or abandoned?

## Data model

| Entity | Purpose |
|---|---|
| `ingredients` | Canonical ingredient names and units |
| `recipes` | Recipe type, identity, yield, directions, and status |
| `recipe_ingredients` | Quantity and preparation for each ingredient |
| `nutrition_estimates` | Sourced per-serving estimates |
| `tags` | Searchable categories such as citrus or low-prep |
| `recipe_tags` | Many-to-many recipe classification |

## Start locally

Requires PostgreSQL 15+.

```bash
createdb squeezestack
psql squeezestack < data/schema.sql
psql squeezestack < data/seed.sql
```

Then try the starter queries in [`docs/QUERIES.md`](docs/QUERIES.md).

## Product path

1. Validate the schema with 20 personally tested juices and sandwiches.
2. Add a small read-only API.
3. Build search, filters, and a recipe detail view.
4. Add cost and usage tracking before recommendations.
5. Consider machine learning only when enough clean behavior data exists.

## Privacy and health guardrails

Do not store medical records, diagnoses, medications, or protected health information in the prototype. Keep personal wellness preferences separate from public recipe data. Any future personalization must be opt-in, explainable, reversible, and reviewed for health claims.

## License

MIT License.
