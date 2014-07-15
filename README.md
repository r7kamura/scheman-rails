# Scheman::Rails
Rails plugin for Scheman.

## Usage
```ruby
# Gemfile
gem "scheman-rails"
```

```sh
# Write your database schema into db/schema.sql
$ echo '
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
);
' > db/schema.sql

# Show diff between the current database schema and db/schema.sql
$ rake db:schema:diff

# Apply diff
$ rake db:schema:apply
```
