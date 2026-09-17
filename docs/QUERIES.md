# Starter Queries

## Published recipes under ten minutes

```sql
SELECT title, prep_minutes, servings
FROM recipes
WHERE status = 'published' AND prep_minutes <= 10
ORDER BY prep_minutes, title;
```

## Browse sandwiches only

```sql
SELECT title, prep_minutes, servings
FROM recipes
WHERE recipe_type = 'sandwich' AND status IN ('tested', 'published')
ORDER BY title;
```

## Ingredient list for one recipe

```sql
SELECT i.name, ri.quantity, ri.unit, ri.preparation
FROM recipe_ingredients ri
JOIN ingredients i ON i.id = ri.ingredient_id
JOIN recipes r ON r.id = ri.recipe_id
WHERE r.slug = 'citrus-reset'
ORDER BY ri.position;
```

## Recipes tagged citrus

```sql
SELECT r.title
FROM recipes r
JOIN recipe_tags rt ON rt.recipe_id = r.id
JOIN tags t ON t.id = rt.tag_id
WHERE t.slug = 'citrus' AND r.status = 'published';
```

## Count recipes by type

```sql
SELECT recipe_type, count(*) AS recipe_count
FROM recipes
GROUP BY recipe_type
ORDER BY recipe_type;
```
