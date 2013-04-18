# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create
u.email = "example@mail.net"
u.password = "password"
u.save

c = u.campaigns.new
c.name = "KSP Campaign"
c.starting_balance = 10000
c.player_name = "Mission Command"
c.date = DateTime.new(2000, 1, 20)
c.save

i = Institution.new
i.name = "Kerbin Space Administration"
i.description = "The state operated Space Association of all Kerbalkind"
i.time_modifier = 0.8
i.penalty_modifier = 0.35
i.reward_modifier = 0.80
i.initial_reputation = 15
i.save

around_kerbal = MissionCategory.create
around_kerbal.name = "Kerbil"
around_kerbal.save

around_mun = MissionCategory.create
around_mun.name = "Mun"
around_mun.minimum_balance = 50000
around_mun.minimum_reputation = 0
around_mun.save

m1 = Mission.create
m1.mission_category_id = around_kerbal.id
m1.name = "Suborbital Flight"
m1.description = "It is time to get this space program going. Get out there and shoot a rocket at least 50km up into the air."
m1.reward  = 10000
m1.minimal_time = 3
m1.maximal_time = 14
m1.save

m2 = Mission.create
m2.mission_category_id = around_kerbal.id
m2.name = "Stable Orbit"
m2.description = "Going up is nice and all, but getting something to never come back down again is even better."
m2.reward = 20000
m2.minimal_time = 5
m2.maximal_time = 20
m2.save

m3 = Mission.create
m3.mission_category_id = around_mun.id
m3.name = "Mun Encounter"
m3.description = "Let's try and get one of your crafts to fly by the dark side of the moon. No need to land or get into a fancy orbit. Oh, and take some pictures while you're at it."
m3.reward = 30000
m3.minimal_time = 20
m3.maximal_time = 25
m3.save

m4 = Mission.create
m4.mission_category_id = around_mun.id
m4.name = "Mun Orbit"
m4.description = "The pictures you sent us were really nice, go try and get a sattelite in an orbit aroudn the Mun to serve as a relay station"
m4.reward = 100000
m4.minimal_time = 25
m4.maximal_time = 50
m4.save

contr = c.contracts.new
contr.mission_id = m2.id
contr.campaign_id = c.id
contr.reward = m2.reward
contr.advance_percent = 20
contr.penalty = m2.reward / 10
contr.time_limit = m2.maximal_time
contr.issued_at = DateTime.new(0, 1, 2)
contr.accepted_at = DateTime.new(0, 1, 3)
contr.completed_at = DateTime.new(0, 1, 5)
contr.save

contr1 = c.contracts.new
contr1.mission_id = m3.id
contr1.campaign_id = c.id
contr1.reward = m3.reward
contr1.advance_percent = 20
contr1.penalty = m3.reward / 10
contr1.time_limit = m3.maximal_time
contr1.issued_at = DateTime.new(0, 1, 4)
contr1.accepted_at = DateTime.new(0, 1, 4)
contr1.completed_at = DateTime.new(0, 1, 10)
contr1.save

contr2 = c.contracts.new
contr2.mission_id = m4.id
contr2.campaign_id = c.id
contr2.reward = m4.reward
contr2.advance_percent = 20
contr2.penalty = m4.reward / 10
contr2.time_limit = m4.maximal_time
contr2.issued_at = DateTime.new(0, 1, 8)
contr2.save

contr3 = c.contracts.new
contr3.mission_id = m1.id
contr3.campaign_id = c.id
contr3.reward = m1.reward * 2
contr3.advance_percent = 40
contr3.penalty = m1.reward / 2
contr3.time_limit = m1.maximal_time
contr3.issued_at = DateTime.new(0, 1, 9)
contr3.save

f = contr3.flights.new
f.campaign_id = c.id
f.name = "SSV Ironcow"
f.ship_cost = 1220000
f.status = :started
f.save
f.status = :failed
f.save

f = contr.flights.new
f.campaign_id = c.id
f.name = "SSV Winterstorm"
f.ship_cost = 80000
f.save
f.status = :started
f.save

f = contr.flights.new
f.campaign_id = c.id
f.name = "SSV Summerwind"
f.ship_cost = 40000
f.save
f.status = :started
f.save

f = contr1.flights.new
f.campaign_id = c.id
f.name = "SSV Starbound"
f.ship_cost = 50000
f.save
f.status = :successful
f.save

f = contr2.flights.new
f.campaign_id = c.id
f.name = "SSV Munlander"
f.ship_cost = 20000
f.save
f.status = :failed
f.save

f = contr2.flights.new
f.campaign_id = c.id
f.name = "SSV Munlander"
f.ship_cost = 25000
f.save
f.status = :failed
f.save

f = contr2.flights.new
f.campaign_id = c.id
f.name = "SSV Munlander"
f.ship_cost = 45000
f.save
f.status = :failed
f.save

f = contr2.flights.new
f.campaign_id = c.id
f.name = "SSV Munlander"
f.ship_cost = 60000
f.save
f.status = :successful
f.save
