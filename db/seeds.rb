# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.name = "Admin"
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
i.time_modifier = 1.2
i.penalty_modifier = 0.35
i.reward_modifier = 0.80
i.initial_reputation = 15
i.save

i = Institution.new
i.name = "Association of rich Kerbals"
i.description = "An association of rich individuals that pay very well"
i.time_modifier = 0.5
i.penalty_modifier = 2
i.reward_modifier = 1.5
i.initial_reputation = 0
i.save

default_pack = u.mission_packs.new
default_pack.name = "Default Pack"
default_pack.description = "A few default missions."
default_pack.official = true
default_pack.public = true
default_pack.save

around_kerbal = MissionCategory.new
around_kerbal.name = "Kerbin"
around_kerbal.save

around_mun = MissionCategory.new
around_mun.name = "Mun"
around_mun.minimum_balance = 50000
around_mun.minimum_reputation = 0
around_mun.save

m1 = default_pack.missions.new
m1.mission_category_id = around_kerbal.id
m1.name = "Suborbital Flight"
m1.description = "It is time to get this space program going. Get out there and shoot a rocket at least 50km up into the air."
m1.reward  = 10000
m1.minimal_time = 3
m1.maximal_time = 14
m1.save

m2 = default_pack.missions.new
m2.mission_category_id = around_kerbal.id
m2.name = "Stable Orbit"
m2.description = "Going up is nice and all, but getting something to never come back down again is even better."
m2.reward = 20000
m2.minimal_time = 5
m2.maximal_time = 20
m2.save

m3 = default_pack.missions.new
m3.mission_category_id = around_mun.id
m3.name = "Mun Encounter"
m3.description = "Let's try and get one of your crafts to fly by the dark side of the moon. No need to land or get into a fancy orbit. Oh, and take some pictures while you're at it."
m3.reward = 30000
m3.minimal_time = 20
m3.maximal_time = 25
m3.save

m4 = default_pack.missions.new
m4.mission_category_id = around_mun.id
m4.name = "Mun Orbit"
m4.description = "The pictures you sent us were really nice, go try and get a sattelite in an orbit aroudn the Mun to serve as a relay station"
m4.reward = 100000
m4.minimal_time = 25
m4.maximal_time = 50
m4.save
