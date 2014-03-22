connection = ActiveRecord::Base.connection

# Create admin user
connection.execute 'INSERT INTO users(email, encrypted_password, remember_token, created_at, updated_at)' +
            " VALUES ('michal@svab.net', '$2a$10$Hq8Yx.FqFSfivC/j.paaee5ohllYl6p7yCeuGfCcLDH52SxiBvHSm', 'lol', now(), now())"

VisaSource.create(
    name: 'USA Visa Waiver Program (ETSA)',
    country: 'us',
    url: 'http://travel.state.gov/content/visas/english/visit/visa-waiver-program.html',
    etag: '13f418-14af5-4f5329f119766',
    description: %{As you're national of a Visa Waiver Program participant country, you might not need a visa to visit the United States for stays of up to 90 days. However, you must have an authorisation under the Electronic System for Travel Authorization (ESTA) prior to boarding any US-bound ship or aircraft.<br/>You can apply for it <a href="http://www.cbp.gov/travel/international-visitors/esta" title="ESTA application site">here</a>.}
)