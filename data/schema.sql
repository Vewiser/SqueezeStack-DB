BEGIN;

CREATE TABLE ingredients (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name text NOT NULL UNIQUE,
  slug text NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  default_unit text,
  allergen_note text,
  created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE recipes (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  recipe_type text NOT NULL CHECK (recipe_type IN ('juice', 'sandwich')),
  title text NOT NULL,
  slug text NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$'),
  summary text NOT NULL,
  servings numeric(6,2) NOT NULL CHECK (servings > 0),
  prep_minutes integer NOT NULL CHECK (prep_minutes >= 0),
  instructions text NOT NULL,
  status text NOT NULL DEFAULT 'draft' CHECK (status IN ('draft', 'tested', 'published', 'retired')),
  created_at timestamptz NOT NULL DEFAULT now(),
  updated_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE recipe_ingredients (
  recipe_id bigint NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  ingredient_id bigint NOT NULL REFERENCES ingredients(id),
  quantity numeric(10,3) NOT NULL CHECK (quantity > 0),
  unit text NOT NULL,
  preparation text,
  position integer NOT NULL CHECK (position > 0),
  PRIMARY KEY (recipe_id, ingredient_id),
  UNIQUE (recipe_id, position)
);

CREATE TABLE nutrition_estimates (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  recipe_id bigint NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  calories_kcal numeric(8,2) CHECK (calories_kcal >= 0),
  carbohydrate_g numeric(8,2) CHECK (carbohydrate_g >= 0),
  protein_g numeric(8,2) CHECK (protein_g >= 0),
  fat_g numeric(8,2) CHECK (fat_g >= 0),
  fiber_g numeric(8,2) CHECK (fiber_g >= 0),
  sugar_g numeric(8,2) CHECK (sugar_g >= 0),
  source_name text NOT NULL,
  source_url text,
  retrieved_on date NOT NULL,
  UNIQUE (recipe_id, source_name)
);

CREATE TABLE tags (
  id bigint GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
  name text NOT NULL UNIQUE,
  slug text NOT NULL UNIQUE CHECK (slug ~ '^[a-z0-9]+(?:-[a-z0-9]+)*$')
);

CREATE TABLE recipe_tags (
  recipe_id bigint NOT NULL REFERENCES recipes(id) ON DELETE CASCADE,
  tag_id bigint NOT NULL REFERENCES tags(id) ON DELETE CASCADE,
  PRIMARY KEY (recipe_id, tag_id)
);

CREATE INDEX idx_recipes_status ON recipes(status);
CREATE INDEX idx_recipes_type_status ON recipes(recipe_type, status);
CREATE INDEX idx_recipe_tags_tag ON recipe_tags(tag_id);

COMMIT;
