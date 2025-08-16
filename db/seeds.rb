fixtures_path = Rails.root.join("test/fixtures")
ActiveRecord::FixtureSet.create_fixtures(fixtures_path, [ :products ])
