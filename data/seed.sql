BEGIN;

INSERT INTO ingredients (name, slug, default_unit) VALUES
  ('Orange', 'orange', 'whole'),
  ('Carrot', 'carrot', 'whole'),
  ('Ginger', 'ginger', 'inch'),
  ('Lemon', 'lemon', 'whole'),
  ('Sourdough Bread', 'sourdough-bread', 'slice'),
  ('Roasted Turkey', 'roasted-turkey', 'ounce'),
  ('Provolone', 'provolone', 'slice'),
  ('Spinach', 'spinach', 'cup'),
  ('Tomato', 'tomato', 'slice'),
  ('Dijon Mustard', 'dijon-mustard', 'tablespoon'),
  ('Avocado', 'avocado', 'whole'),
  ('Cucumber', 'cucumber', 'slice'),
  ('Hummus', 'hummus', 'tablespoon'),
  ('Whole Grain Bread', 'whole-grain-bread', 'slice');

INSERT INTO recipes (recipe_type, title, slug, summary, servings, prep_minutes, instructions, status) VALUES
  ('juice', 'Citrus Reset', 'citrus-reset', 'A bright orange, carrot, lemon, and ginger juice.', 2, 10,
   'Wash produce. Peel only when needed. Juice ingredients. Stir, divide, and serve immediately.', 'tested'),
  ('sandwich', 'Turkey Signal Stack', 'turkey-signal-stack', 'A warm turkey, provolone, spinach, and tomato sandwich with Dijon.', 1, 10,
   'Spread Dijon on the bread. Layer turkey, provolone, spinach, and tomato. Close the sandwich and toast until the bread is crisp and the cheese softens.', 'tested'),
  ('sandwich', 'Garden Crunch Stack', 'garden-crunch-stack', 'A fresh avocado, cucumber, spinach, and hummus sandwich.', 1, 8,
   'Spread hummus on both bread slices. Layer avocado, cucumber, and spinach. Close, slice, and serve.', 'tested');

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, preparation, position)
SELECT r.id, i.id, v.quantity, v.unit, v.preparation, v.position
FROM recipes r
JOIN (VALUES
  ('orange', 3.000, 'whole', 'peeled', 1),
  ('carrot', 4.000, 'whole', 'trimmed', 2),
  ('lemon', 0.500, 'whole', 'peeled', 3),
  ('ginger', 0.500, 'inch', 'washed', 4)
) AS v(slug, quantity, unit, preparation, position) ON true
JOIN ingredients i ON i.slug = v.slug
WHERE r.slug = 'citrus-reset';

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, preparation, position)
SELECT r.id, i.id, v.quantity, v.unit, v.preparation, v.position
FROM recipes r
JOIN (VALUES
  ('sourdough-bread', 2.000, 'slice', 'lightly toasted', 1),
  ('dijon-mustard', 1.000, 'tablespoon', 'spread', 2),
  ('roasted-turkey', 4.000, 'ounce', 'sliced', 3),
  ('provolone', 1.000, 'slice', NULL, 4),
  ('spinach', 0.250, 'cup', 'washed', 5),
  ('tomato', 2.000, 'slice', NULL, 6)
) AS v(slug, quantity, unit, preparation, position) ON true
JOIN ingredients i ON i.slug = v.slug
WHERE r.slug = 'turkey-signal-stack';

INSERT INTO recipe_ingredients (recipe_id, ingredient_id, quantity, unit, preparation, position)
SELECT r.id, i.id, v.quantity, v.unit, v.preparation, v.position
FROM recipes r
JOIN (VALUES
  ('whole-grain-bread', 2.000, 'slice', NULL, 1),
  ('hummus', 2.000, 'tablespoon', 'spread', 2),
  ('avocado', 0.500, 'whole', 'sliced', 3),
  ('cucumber', 6.000, 'slice', NULL, 4),
  ('spinach', 0.250, 'cup', 'washed', 5)
) AS v(slug, quantity, unit, preparation, position) ON true
JOIN ingredients i ON i.slug = v.slug
WHERE r.slug = 'garden-crunch-stack';

INSERT INTO tags (name, slug) VALUES
  ('Citrus', 'citrus'),
  ('Quick Prep', 'quick-prep'),
  ('Sandwich', 'sandwich'),
  ('Vegetarian', 'vegetarian');

INSERT INTO recipe_tags (recipe_id, tag_id)
SELECT r.id, t.id
FROM recipes r
JOIN tags t ON t.slug IN ('citrus', 'quick-prep')
WHERE r.slug = 'citrus-reset';

INSERT INTO recipe_tags (recipe_id, tag_id)
SELECT r.id, t.id
FROM recipes r
JOIN tags t ON t.slug IN ('sandwich', 'quick-prep')
WHERE r.slug = 'turkey-signal-stack';

INSERT INTO recipe_tags (recipe_id, tag_id)
SELECT r.id, t.id
FROM recipes r
JOIN tags t ON t.slug IN ('sandwich', 'quick-prep', 'vegetarian')
WHERE r.slug = 'garden-crunch-stack';

COMMIT;
