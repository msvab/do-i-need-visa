User.create!([
  {email: "michal@svab.net", encrypted_password: "$2a$10$Hq8Yx.FqFSfivC/j.paaee5ohllYl6p7yCeuGfCcLDH52SxiBvHSm", confirmation_token: nil, remember_token: "lol"}
])
Visa.create!([
  {citizen: "AD", visa_source_id: 1},
  {citizen: "AU", visa_source_id: 1},
  {citizen: "AT", visa_source_id: 1},
  {citizen: "BE", visa_source_id: 1},
  {citizen: "BN", visa_source_id: 1},
  {citizen: "CL", visa_source_id: 1},
  {citizen: "CZ", visa_source_id: 1},
  {citizen: "DK", visa_source_id: 1},
  {citizen: "EE", visa_source_id: 1},
  {citizen: "FI", visa_source_id: 1},
  {citizen: "FR", visa_source_id: 1},
  {citizen: "DE", visa_source_id: 1},
  {citizen: "GR", visa_source_id: 1},
  {citizen: "HU", visa_source_id: 1},
  {citizen: "IS", visa_source_id: 1},
  {citizen: "IE", visa_source_id: 1},
  {citizen: "IT", visa_source_id: 1},
  {citizen: "JP", visa_source_id: 1},
  {citizen: "KR", visa_source_id: 1},
  {citizen: "LV", visa_source_id: 1},
  {citizen: "LI", visa_source_id: 1},
  {citizen: "LT", visa_source_id: 1},
  {citizen: "LU", visa_source_id: 1},
  {citizen: "MT", visa_source_id: 1},
  {citizen: "MC", visa_source_id: 1},
  {citizen: "NL", visa_source_id: 1},
  {citizen: "NZ", visa_source_id: 1},
  {citizen: "NO", visa_source_id: 1},
  {citizen: "PT", visa_source_id: 1},
  {citizen: "SM", visa_source_id: 1},
  {citizen: "SG", visa_source_id: 1},
  {citizen: "SK", visa_source_id: 1},
  {citizen: "SI", visa_source_id: 1},
  {citizen: "ES", visa_source_id: 1},
  {citizen: "SE", visa_source_id: 1},
  {citizen: "CH", visa_source_id: 1},
  {citizen: "TW", visa_source_id: 1},
  {citizen: "GB", visa_source_id: 1}
])
VisaSource.create!([
  {name: "USA Visa Waiver Program (ETSA)", country: "US", url: "http://travel.state.gov/content/visas/english/visit/visa-waiver-program.html", selector: '#main .parsys', page_hash: '07d9b9b5eaf25830eb9987adc78acba7', updated: false, visa_required: true, on_arrival: false, description: "As you're national of a Visa Waiver Program participant country, you might not need a visa to visit the United States for stays of up to 90 days. However, you must have an authorisation under the Electronic System for Travel Authorization (ESTA) prior to boarding any US-bound ship or aircraft.<br/>You can apply for it <a href=\"http://www.cbp.gov/travel/international-visitors/esta\" title=\"ESTA application site\">here</a>."}
])
