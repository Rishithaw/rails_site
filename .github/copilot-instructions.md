## copilot / AI agent instructions — rails_site

Purpose: Give an AI coding agent the minimal, practical knowledge to be productive in this Rails app.

- Tech stack (quick): Ruby 3.2.x (Dockerfile ARG: 3.2.3), Rails 8.0.x (Gemfile), Propshaft asset pipeline, Importmap, Turbo & Stimulus, SQLite3 (dev), Bootsnap, Kamal/Thruster for container/deploy workflows.

Quickstart (dev):
- Install gems: `bundle install` (project uses vendor/bundle in some flows).
- Start dev server: `./bin/dev` (delegates to `./bin/rails server`).
- Prepare DB: `bin/rails db:prepare` (the Docker entrypoint runs this automatically for production images).
- Run tests: `bin/rails test` or `bundle exec rake` (Rakefile loads the Rails app tasks).
- Precompile assets: `bin/rails assets:precompile` (used by Dockerfile for production builds).

Key files and what they tell you
- `Gemfile` — confirms Rails 8, propshaft, importmap-rails, turbo-rails, stimulus-rails, and project-specific gems: `solid_cache`, `solid_queue`, `solid_cable` (database-backed cache/job/cable adapters), plus dev tools like `brakeman` and `rubocop-rails-omakase`.
- `Dockerfile` — production-focused build. The Dockerfile precompiles bootsnap and assets and expects `RAILS_MASTER_KEY` at runtime. Don't use it as your fast dev loop; it's for production images (Kamal/Thruster integration). See `bin/docker-entrypoint` for DB prepare behavior.
- `bin/docker-entrypoint` — sets jemalloc and runs `bin/rails db:prepare` when the final command starts the Rails server.
- `config/application.rb` — autoload/lib note: `config.autoload_lib(ignore: %w[assets tasks])` — avoid adding non-.rb directories under `lib` unless intended. Also Rails defaults are 8.0.
- `config/routes.rb` — small route surface; notable items:
  - Health check: `get "up" => "rails/health#show"` exposes `/up` returning 200 if booted successfully.
  - PWA endpoints are commented but rendered from `app/views/pwa/*` (manifest.json.erb, service-worker.js).
- `app/views/pwa/` — place to update PWA manifest and service worker; links to these assets should be present in `application.html.erb` if used.

Project-specific conventions & patterns
- Assets: uses Propshaft (modern asset pipeline) + importmap for JS; prefer editing files under `app/assets/*` and `app/javascript` conventions used by importmap (inspect `app/assets/stylesheets/application.css`).
- PWA: dynamic manifest and service-worker are rendered from `app/views/pwa/` (server-rendered JSON/JS ERB templates). Example files: `app/views/pwa/manifest.json.erb`, `app/views/pwa/service-worker.js`.
- Background jobs, cache, and Action Cable: adapters use `solid_queue`, `solid_cache`, `solid_cable` — expect database-backed behavior rather than Redis; inspect `config` and `app/jobs` for job specifics.
- Error pages: `public/` contains static error pages (`404.html`, `500.html`, etc.) — update those for UX changes.
- Vendor bundling: `vendor/bundle` is present in the workspace; CI or local workflows may expect `bundle install --path vendor/bundle` or Docker's `BUNDLE_PATH` used in the Dockerfile.

Testing / static analysis / security
- `brakeman` and `rubocop-rails-omakase` are in the Gemfile for scanning; use them from the dev group:
  - `bundle exec brakeman` (security scan)
  - `bundle exec rubocop` (style)

Deployment & Docker notes
- The `Dockerfile` is production-oriented: it builds gems in a separate stage, precompiles bootsnap, and uses `./bin/thrust` + `./bin/rails server` as the default CMD. It expects `RAILS_MASTER_KEY` at runtime; the image precompiles assets without a real master key using a dummy secret (see Dockerfile). Use Kamal to deploy if you need a standard deployment flow.
- The entrypoint (`bin/docker-entrypoint`) will run `bin/rails db:prepare` when the container starts the server, so schema/migrations are handled at runtime in that flow.

What to check before editing or adding features
- If you touch background jobs, check which adapter is in use (`solid_queue`) — tests/local env may differ from production.
- If you modify loader paths under `lib/`, follow `config.autoload_lib(ignore: ...)` conventions.
- For changes to assets or manifest, run `bin/rails assets:precompile` to ensure the production build behaves like CI/Docker.

Useful anchors to inspect when solving tasks
- `README.md` — scaffold notes and developer instructions (placeholder). Update this when you add concrete setup steps.
- `Gemfile`, `Dockerfile`, `bin/docker-entrypoint`, `config/application.rb`, `config/routes.rb`, `app/views/pwa/*`, `app/assets/stylesheets/application.css`.

If anything here is unclear or you want more examples (e.g., how jobs are wired, example requests for the PWA manifest, or test harness specifics), tell me which area and I'll expand with code snippets from the repo.
