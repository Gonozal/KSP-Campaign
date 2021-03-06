Test  Version 0.1 here: http://ksp-campaign.herokuapp.com
-------------------------------
Disclaimer: At the moment this is hosted as a free app on heroku. Heroku as a free service is incredibly slow. Not only that, but if there is no traffic to an app for a few minutes the server goes to sleep and can take up to a minute to get back on it's feet. If the website does not seem to load, just wait a minute and try again. Continued use should be ok-ish.
If there is a somewhat decent interest in this website, I'll host it on a way faster VPS.



What do you mean by "Campaign Manager"?
-------------------------------
Basically, it's a web app that allows you to create and keep track of your own campaign. I started working on this when I tried to use [LordStimpy's Campaign ruleset]("http://forum.kerbalspaceprogram.com/showthread.php/11778-Stimpy-s-Campaign-Mode-Budget-Rules") (more up-to date thread lost in forum crash). I really liked the idea of keeping track of money and trying to build the cheapest rockets possible to achieve a goal. However, I did not want to keep track of it all on a sheet of paper, some means to keep track of it digitally (and I do not mean Word or Excel) was needed.


What can I do with it?
-------------------------------
At the moment, It allows you to either start a new mission on your own with an OK mission reward, but no penalties on failure. Alternatively you can request 3rd Party contracts. Third parties have modifiers to reward, time limit, advance and penalties on failure that are applied to missions belonging to those parties. Usually that means a bigger reward for completing a mission, but less time to do so and a penalty should you abort the mission.
Once you've created a mission you can assign Flights (for lack of a better word. Launches? Rockets? Attempts?) to them. Those have a cost (building a rocket obviously costs money) and can either succeed or fail. A successful flight automatically completes the mission, but if you fail with a flight you can try again. You can also specifiy the amount of kerbals that died on a flight and the amount of debries dropped on those poor kerbals below for added penalties. To give you a bit more control over how much a mission pays, you can specify a custom amount of money you wish to receive or loose at the end of each flight.


How does it integrate into the game?
-------------------------------
It does not. You create a campaign, missions and flights ond the website, then go into KSP and try to fullfill whatever goals you have set. Once your launch was succesfull or failed horribly, you go back to the website and enter your results. Writing a plugin that does all that for you would be somewhat out of my league - or would at the very least require way more time than what I have ony my hands right now.


Do I need mods/plugins for it to work?
-------------------------------
See above. Nonetheless either MechJeb, Kerbal Engineer Redux, or some other plugin that can calculate your ship's cost is highly recommended.


Will I be able to create my own missions?
-------------------------------
Eventually, yes. There will be the option to create your own set of missions. I could implement that rather quickly, but doing it right and with a nice interface takes a bit more time.
Further down the road I could also add the possibility to share missions or sets of missions with others, but that would require some serious work.


Of what use is this if no mod I use has balanced prices for its parts?
-------------------------------
Well, you're right. I've written something myself that balances prices based on engine/fuel capacity and efficiency, but it's a rather nasty piece of ruby code (needs ruby 1.9.1+) that also relies on the part.cfg being converted to json before. That can be done by a programm my brother wrote in c# using Manticor's kerbaldata. But that either requires windows or mono on linux/mac. So you'd need to have ruby 1.9.1+ (usually found on Macs) and be able to run an .exe (usually on windows, needs mono for mac). Also, booth tools don't have a gui but rely on relative path and/or command line input. Long story short: There is a way to balance the prices, but it's messy right now and I'd like to streamline it before releasing it.


Any planned features?
-------------------------------
* Time management
* User created missions
* More premade missions
* A way to display the mission description without breaking the design
* Reputation for 3rd parties, influencing rewards, advance %, time limit and penalty on failure


Give me technical details
-------------------------------
The web app is written in Ruby on Rails 4.0.0beta1, uses devise for user authentication and cancan for user authorisation. The design is powered by Twitter Bootstrap.
Most links and forms on the page use ajax to update the site, so disabling JS will most likely break it.

If you want you can visit the project over on [**Github**]("https://github.com/Gonozal/KSP-Campaign"). It's licensed under the MIT License, so feel free to do with it whatever you want. I'm not going into how to host your own rails app here, there are plenty of guides on the internet as to how to do it.

Last but not least, I'd like to thank my brother for helping me out with the design, JS, any tougher programming/rails questions I had and for pushing me to write cleaner code (for what it's worth. At some point I kinda threw that over board I'm afraid)


License
-------------------------------
Kerbal Campaign Manager is released under the MIT License.