# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

u = User.new
u.name = "Admin"
u.email = "leradomendar@googlemail.com"
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
i.time_modifier = 1.4
i.penalty_modifier = 0.25
i.reward_modifier = 0.75
i.initial_reputation = 25
i.save

i = Institution.new
i.name = "Association of rich Kerbals"
i.description = "An association of rich individuals that pay very well"
i.time_modifier = 0.4
i.penalty_modifier = 2
i.reward_modifier = 1.3
i.initial_reputation = 0
i.save

default_pack = u.mission_packs.new
default_pack.name = "Default Pack"
default_pack.description = "A few default missions."
default_pack.official = true
default_pack.public = true
default_pack.save

kerbin = MissionCategory.new
kerbin.name = "Kerbin"
kerbin.save

mun = MissionCategory.new
mun.name = "Mun"
mun.save

minmus = MissionCategory.new
minmus.name = "Minmus"
minmus.save

eve = MissionCategory.new
eve.name = "Eve"
eve.save

gilly = MissionCategory.new
gilly.name = "Gilly"
gilly.save

moho = MissionCategory.new
moho.name = "Moho"
moho.save

duna = MissionCategory.new
duna.name = "Duna"
duna.save

ike = MissionCategory.new
ike.name = "Ike"
ike.save

dres = MissionCategory.new
dres.name = "Dres"
dres.save

jool = MissionCategory.new
jool.name = "Jool"
jool.save

laythe = MissionCategory.new
laythe.name = "Laythe"
laythe.save

vall = MissionCategory.new
vall.name = "Vall"
vall.save

tylo = MissionCategory.new
tylo.name = "Tylo"
tylo.save

bop = MissionCategory.new
bop.name = "Bop"
bop.save

pol = MissionCategory.new
pol.name = "Pol"
pol.save

eeloo = MissionCategory.new
eeloo.name = "Eeloo"
eeloo.save

kerbol = MissionCategory.new
kerbol.name = "Kerbol (Sun)"
kerbol.save

other = MissionCategory.new
other.name = "Other"
other.save

m1 = default_pack.missions.new
m1.mission_category_id = kerbin.id
m1.name = "Suborbital Flight"
m1.description = "It is time to get this space program going. Get out there and shoot a rocket at least 40km up into the air."
m1.reward  = 6000
m1.minimal_time = 1
m1.maximal_time = 3
m1.save

m2 = default_pack.missions.new
m2.mission_category_id = kerbin.id
m2.name = "I'm ging to Spaaaaace, almost"
m2.description = "It's time to leave Kerbin's atmosphere. That means packing enough fuel to get at least  80km above ground."
m2.reward = 8000
m2.minimal_time = 2
m2.maximal_time = 5
m2.save

m3 = default_pack.missions.new
m3.mission_category_id = kerbin.id
m3.name = "Stable Orbit"
m3.description = "There's only one thing better than flying, and that is flying forever. - Some random kerbal we asked on the street.
He might have a point, though. Go and test his hypothesis and launch a kerbal into a stable orbit."
m3.reward = 18000
m3.minimal_time = 3
m3.maximal_time = 8
m3.save


m4 = default_pack.missions.new
m4.mission_category_id = kerbin.id
m4.name = "Kerbinsynchronous Orbit"
m4.description = "Our scientists came up with a great idea: Street lamps. Only in space!
To make that dream a reality, we need to put a sattelite equiped with lots of floodlights into a kerbinsynchronous orbit."
m4.reward = 20000
m4.minimal_time = 4
m4.maximal_time = 10
m4.save

m5 = default_pack.missions.new
m5.mission_category_id = mun.id
m5.name = "Mun Encounter"
m5.description = "Let's try and get one of your crafts to fly by the dark side of the moon. No need to land or get into a fancy orbit. Oh, and take some pictures while you're at it."
m5.reward = 35000
m5.minimal_time = 15
m5.maximal_time = 25
m5.save

m6 = default_pack.missions.new
m6.mission_category_id = mun.id
m6.name = "Mun Orbit"
m6.description = "The pictures you sent us were really nice, go try and get a sattelite in an orbit aroudn the Mun to serve as a relay station"
m6.reward = 50000
m6.minimal_time = 25
m6.maximal_time = 50
m6.save

m6 = default_pack.missions.new
m6.mission_category_id = mun.id
m6.name = "Mun Landin"
m6.description = "On of our top scientists said, the ground of the Mun was like quicksand.
To confirm this, we need you to send a team of kerbals to the Mun and volunteer someone to make a short trip."
m6.reward = 100000
m6.minimal_time = 35
m6.maximal_time = 60
m6.save
