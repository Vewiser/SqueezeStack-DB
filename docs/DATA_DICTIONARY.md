# Data Dictionary

## Core conventions

- Primary keys use generated `bigint` values.
- Names are human-readable; slugs are stable URL identifiers.
- Quantities use decimal values plus an explicit unit.
- Nutrition is stored as an estimate with a source and retrieval date.
- Soft workflow states distinguish drafts from tested and published recipes.

## Tables

### ingredients

Canonical ingredient record. `name` and `slug` are unique. `default_unit` is a convenience, not a conversion rule.

### recipes

Stores recipe type (`juice` or `sandwich`), title, summary, yield, preparation time, instructions, and publication state. A recipe must be tested before it can become `published`.

### recipe_ingredients

Joins recipes to ingredients. The unique constraint prevents the same ingredient from being entered twice for one recipe.

### nutrition_estimates

One sourced estimate per recipe and source. Values are per serving and nullable when unknown; zero must only mean a measured or sourced zero.

### tags / recipe_tags

Flexible classification for search. Tags must describe the recipe, not make medical promises.
