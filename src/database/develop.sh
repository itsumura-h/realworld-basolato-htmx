nim c -r -d:reset --threads:off -f ./database/migrations/default/migrate.nim
nim c -r --threads:off -f ./database/seeders/seed.nim
