# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.create
u.email = "leradomendar@googlemail.com"
u.password = "thisisnotapassword"
u.save

c = u.campaigns.new
c.name = "KSP Campaign"
c.starting_balance = 10000
c.player_name = "Mission Command"
c.save

i = Institution.new
i.name = "Kerbal Space Administration"
i.description = "The state operated Space Association of all Kerbalkind"
i.time_modifier = 0.8
i.penalty_modifier = 0.35
i.reward_modifier = 0.80
i.initial_reputation = 15
i.save

around_kerbal = MissionCategory.create
around_kerbal.name = "Kerbal"
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

m2 = Mission.create
m2.mission_category_id = around_mun.id
m2.name = "Mun Encounter"
m2.description = "Let's try and get one of your crafts to fly by the dark side of the moon. No need to land or get into a fancy orbit. Oh, and take some pictures while you're at it."
m2.reward = 30000
m2.minimal_time = 20
m2.maximal_time = 25
m2.save

m2 = Mission.create
m2.mission_category_id = around_mun.id
m2.name = "Mun Orbit"
m2.description = "The pictures you sent us were really nice, go try and get a sattelite in an orbit aroudn the Mun to serve as a relay station"
m2.reward = 100000
m2.minimal_time = 25
m2.maximal_time = 50
m2.save
