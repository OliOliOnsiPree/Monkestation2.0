//Monkestation edit: Bulldog and c20r moved to uplink kits
/datum/uplink_item/bundles_tc/cyber_implants
	name = "Cybernetic Implants Bundle"
	desc = "A random selection of cybernetic implants. Guaranteed 5 high quality implants. Comes with an autosurgeon."
	item = /obj/item/storage/box/cyber_implants
	cost = 40
	surplus = 30
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/bundles_tc/medical
	name = "Medical bundle"
	desc = "The support specialist: Aid your fellow operatives with this medical bundle. Contains a tactical medkit, \
			a Donksoft LMG, a box of riot darts and a magboot MODsuit module to rescue your friends in no-gravity environments."
	item = /obj/item/storage/backpack/duffelbag/syndie/med/medicalbundle
	cost = 25 // normally 31
	surplus = 40
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/bundles_tc/sniper
	name = "Sniper bundle"
	desc = "Elegant and refined: Contains a collapsed sniper rifle in an expensive carrying case, \
			two .50 BMG disruptor magazines, a free suppressor, and a sharp-looking tactical turtleneck suit. \
			We'll throw in a free red tie if you order NOW."
	item = /obj/item/storage/briefcase/sniperbundle
	cost = 20 // normally 27, the suit and office supplies are free!
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/bundles_tc/firestarter
	name = "Spetsnaz Pyro bundle"
	desc = "For systematic suppression of carbon lifeforms in close quarters: Contains an Elite MODsuit with a flamethrower attachment, \
			Stechkin APS machine pistol, two incendiary magazines, a minibomb and a stimulant syringe. \
			Order NOW and comrade Boris will throw in an extra tracksuit."
	item = /obj/item/storage/backpack/duffelbag/syndie/firestarter
	cost = 30
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/bundles_tc/induction_kit
	name = "Syndicate Induction Kit"
	desc = "Met a fellow syndicate agent on the station? Kept some TC in reserve just in case? Or are you communicating with one via the Syndicate channel? \
			Get this kit and you'll be able to induct them into your operative team via a special implant. \
			Additionally, it contains an assortment of useful gear for new operatives, including a space suit, an Ansem pistol, two spare magazines, and more! \
			*NOT* for usage with Reinforcements, and does not brainwash the target!"
	item = /obj/item/storage/box/syndie_kit/induction_kit
	cost = 10
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/bundles_tc/cowboy
	name = "Syndicate Outlaw Kit"
	desc = "There've been high tales of an outlaw 'round these parts. A fella so ruthless and efficient no ranger could ever capture 'em. \
	Now you can be just like 'em! \
	This kit contains armor-lined cowboy equipment, a custom revolver and holster, and a horse with a complimentary apple to tame. \
	A lighter is also included, though you must supply your own smokes."
	item = /obj/item/storage/box/syndie_kit/cowboy
	cost = 18
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/rawketlawnchair
	name = "84mm Rocket Propelled Grenade Launcher"
	desc = "A reusable rocket propelled grenade launcher preloaded with a low-yield 84mm HE round. \
		Guaranteed to send your target out with a bang or your money back!"
	item = /obj/item/gun/ballistic/rocketlauncher
	cost = 8
	surplus = 30
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/pie_cannon
	name = "Banana Cream Pie Cannon"
	desc = "A special pie cannon for a special clown, this gadget can hold up to 20 pies and automatically fabricates one every two seconds!"
	cost = 10
	item = /obj/item/pneumatic_cannon/pie/selfcharge
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/dangerous/bananashield
	name = "Bananium Energy Shield"
	desc = "A clown's most powerful defensive weapon, this personal shield provides near immunity to ranged energy attacks \
		by bouncing them back at the ones who fired them. It can also be thrown to bounce off of people, slipping them, \
		and returning to you even if you miss. WARNING: DO NOT ATTEMPT TO STAND ON SHIELD WHILE DEPLOYED, EVEN IF WEARING ANTI-SLIP SHOES."
	item = /obj/item/shield/energy/bananium
	cost = 16
	surplus = 40 //monkestation edit: from 0 to 40
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/dangerous/clownsword
	name = "Bananium Energy Sword"
	desc = "An energy sword that deals no damage, but will slip anyone it contacts, be it by melee attack, thrown \
	impact, or just stepping on it. Beware friendly fire, as even anti-slip shoes will not protect against it."
	item = /obj/item/melee/energy/sword/bananium
	cost = 3
	surplus = 100 //monkestation edit: from 0 to 100(its funny)
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/dangerous/clownoppin
	name = "Ultra Hilarious Firing Pin"
	desc = "A firing pin that, when inserted into a gun, makes that gun only useable by clowns and clumsy people and makes that gun honk whenever anyone tries to fire it."
	cost = 1 //much cheaper for clown ops than for clowns
	item = /obj/item/firing_pin/clown/ultra
	purchasable_from = UPLINK_CLOWN_OPS
	illegal_tech = FALSE
	surplus = 80

/datum/uplink_item/dangerous/clownopsuperpin
	name = "Super Ultra Hilarious Firing Pin"
	desc = "Like the ultra hilarious firing pin, except the gun you insert this pin into explodes when someone who isn't clumsy or a clown tries to fire it."
	cost = 4 //much cheaper for clown ops than for clowns
	item = /obj/item/firing_pin/clown/ultra/selfdestruct
	purchasable_from = UPLINK_CLOWN_OPS
	illegal_tech = FALSE
	surplus = 80

/datum/uplink_item/dangerous/shotgun
	name = "Bulldog Shotgun"
	desc = "A fully-loaded semi-automatic drum-fed shotgun, complete with a secondary magazine. Compatible with all 12g rounds. Designed for close \
			quarter anti-personnel engagements."
	item = /obj/item/gun/ballistic/shotgun/bulldog
	cost = 8
	surplus = 40
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/smg
	name = "C-20r Submachine Gun"
	desc = "A fully-loaded Scarborough Arms bullpup submachine gun. The C-20r fires .45 rounds with a \
			24-round magazine and is compatible with suppressors."
	item = /obj/item/gun/ballistic/automatic/c20r
	cost = 10
	surplus = 40
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/shield
	name = "Energy Shield"
	desc = "An incredibly useful personal shield projector, capable of reflecting energy projectiles and defending \
			against other attacks. Pair with an Energy Sword for a killer combination."
	item = /obj/item/shield/energy
	cost = 16
	surplus = 40 //monkestation edit: from 20 to 40
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/machinegun
	name = "L6 Squad Automatic Weapon"
	desc = "A fully-loaded Aussec Armoury belt-fed machine gun. \
			This deadly weapon has a massive 50-round magazine of devastating 7.12x82mm ammunition."
	item = /obj/item/gun/ballistic/automatic/l6_saw
	cost = 18
	surplus = 10 //monkestation edit: from 0 to 10
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/carbine
	name = "M-90gl Carbine"
	desc = "A fully-loaded, specialized three-round burst carbine that fires 5.56mm ammunition from a 30 round magazine \
			with a 40mm underbarrel grenade launcher. Use secondary-fire to fire the grenade launcher."
	item = /obj/item/gun/ballistic/automatic/m90
	cost = 14
	surplus = 50
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/sniper
	name = "Anti-Materiel Sniper Rifle"
	desc = "An outdated, but still extremely powerful anti-material sniper rifle. Fires .50 BMG cartridges from a 6 round magazine. \
			Can be fitted with a suppressor. If anyone asks how that even works, tell them it's Nanotrasen's fault."
	item = /obj/item/gun/ballistic/rifle/sniper_rifle/syndicate
	cost = 16
	surplus = 25
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/pistol_nukeop
	name = "Ansem Pistol"
	desc = "A small, easily concealable handgun that uses 10mm auto rounds in 8-round magazines and is compatible \
			with suppressors."
	item = /obj/item/gun/ballistic/automatic/pistol/clandestine
	cost = 6
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/surplus_smg
	name = "Surplus SMG"
	desc = "A horribly outdated automatic weapon. Why would you want to use this?"
	item = /obj/item/gun/ballistic/automatic/plastikov
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/dangerous/foamsmg
	name = "Toy Submachine Gun"
	desc = "A fully-loaded Donksoft bullpup submachine gun that fires riot grade darts with a 20-round magazine."
	item = /obj/item/gun/ballistic/automatic/c20r/toy
	cost = 5
	surplus = 70 //monkestation edit: from 0 to 70
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/dangerous/foammachinegun
	name = "Toy Machine Gun"
	desc = "A fully-loaded Donksoft belt-fed machine gun. This weapon has a massive 50-round magazine of devastating \
			riot grade darts, that can briefly incapacitate someone in just one volley."
	item = /obj/item/gun/ballistic/automatic/l6_saw/toy
	cost = 10
	surplus = 70 //monkestation edit: from 0 to 70
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/stealthy_weapons/cqc
	name = "CQC Manual"
	desc = "A manual that teaches a single user tactical Close-Quarters Combat before self-destructing."
	item = /obj/item/book/granter/martial/cqc
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	cost = 13
	surplus = 60 //monkestation edit: from 0 to 60

/datum/uplink_item/ammo/pistol_nukeop
	name = "10mm Handgun Magazine"
	desc = "An additional 8-round 10mm magazine, compatible with the Ansem pistol."
	item = /obj/item/ammo_box/magazine/m10mm
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/pistolap_nukeop
	name = "10mm Armour Piercing Magazine"
	desc = "An additional 8-round 10mm magazine, compatible with the Ansem pistol. \
			These rounds are less effective at injuring the target but penetrate protective gear."
	item = /obj/item/ammo_box/magazine/m10mm/ap
	cost = 3
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/pistolhp_nukeop
	name = "10mm Hollow Point Magazine"
	desc = "An additional 8-round 10mm magazine, compatible with the Ansem pistol. \
			These rounds are more damaging but ineffective against armour."
	item = /obj/item/ammo_box/magazine/m10mm/hp
	cost = 3
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/pistolfire_nukeop
	name = "10mm Incendiary Magazine"
	desc = "An additional 8-round 10mm magazine, compatible with the Ansem pistol. \
			Loaded with incendiary rounds which inflict less damage, but ignite the target."
	item = /obj/item/ammo_box/magazine/m10mm/fire
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/shotgun
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/shotgun/bag
	name = "12g Ammo Duffel Bag"
	desc = "A duffel bag filled with enough 12g ammo to supply an entire team, at a discounted price."
	item = /obj/item/storage/backpack/duffelbag/syndie/ammo/shotgun
	cost = 12

/datum/uplink_item/ammo/shotgun/buck
	name = "12g Buckshot Drum"
	desc = "An additional 8-round buckshot magazine for use with the Bulldog shotgun. Front towards enemy."
	item = /obj/item/ammo_box/magazine/m12g

/datum/uplink_item/ammo/shotgun/slug
	name = "12g Slug Drum"
	desc = "An additional 8-round slug magazine for use with the Bulldog shotgun. \
			Now 8 times less likely to shoot your pals."
	cost = 3
	item = /obj/item/ammo_box/magazine/m12g/slug

/datum/uplink_item/ammo/shotgun/dragon
	name = "12g Dragon's Breath Drum"
	desc = "An alternative 8-round dragon's breath magazine for use in the Bulldog shotgun. \
			'I'm a fire starter, twisted fire starter!'"
	item = /obj/item/ammo_box/magazine/m12g/dragon
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/shotgun/meteor
	name = "12g Meteorslug Shells"
	desc = "An alternative 8-round meteorslug magazine for use in the Bulldog shotgun. \
		Great for blasting holes into the hull and knocking down enemies."
	item = /obj/item/ammo_box/magazine/m12g/meteor
	purchasable_from = UPLINK_NUKE_OPS

//MONKESTATION REMOVAL
// /datum/uplink_item/ammo/a40mm
// 	name = "40mm Grenade Box"
// 	desc = "A box of 40mm HE grenades for use with the M-90gl's under-barrel grenade launcher. Your teammates will ask you to not shoot these down small hallways."
// 	item = /obj/item/ammo_box/a40mm
// 	cost = 6
// 	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/smg/bag
	name = ".45 Ammo Duffel Bag"
	desc = "A duffel bag filled with enough .45 ammo to supply an entire team, at a discounted price."
	item = /obj/item/storage/backpack/duffelbag/syndie/ammo/smg
	cost = 20 //instead of 27 TC
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/smg
	name = ".45 SMG Magazine"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun."
	item = /obj/item/ammo_box/magazine/smgm45
	cost = 3
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/smgap
	name = ".45 Armor Piercing SMG Magazine"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun.\
			These rounds are less effective at injuring the target but penetrate protective gear."
	item = /obj/item/ammo_box/magazine/smgm45/ap
	cost = 5
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/smgfire
	name = ".45 Incendiary SMG Magazine"
	desc = "An additional 24-round .45 magazine suitable for use with the C-20r submachine gun.\
			Loaded with incendiary rounds which inflict little damage, but ignite the target."
	item = /obj/item/ammo_box/magazine/smgm45/incen
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/sniper
	cost = 3
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/sniper/basic
	name = ".50 BMG Magazine"
	desc = "An additional standard 6-round magazine for use with .50 sniper rifles."
	item = /obj/item/ammo_box/magazine/sniper_rounds

/datum/uplink_item/ammo/sniper/surplusbox
	name = ".50 BMG Surplus Magazine Box"
	desc = "A box full of surplus .50 BMG magazines. Not as good as high quality magazines, \
			usually lacking the penetrative power and impact, but good enough to keep the gun firing. \
			Useful for arming a squad."
	cost = 7 //1 TC per magazine
	item = /obj/item/storage/box/syndie_kit/surplus

/datum/uplink_item/ammo/sniper/penetrator
	name = ".50 BMG Penetrator Magazine"
	desc = "A 6-round magazine of penetrator ammo designed for use with .50 sniper rifles. \
			Can pierce walls and multiple enemies."
	item = /obj/item/ammo_box/magazine/sniper_rounds/penetrator
	cost = 4

/datum/uplink_item/ammo/sniper/incendiary
	name = ".50 BMG Incendiary Magazine"
	desc = "A 6-round magazine of incendiary ammo. \
			Sets your enemies ablaze, along with everyone else next to them!"
	item = /obj/item/ammo_box/magazine/sniper_rounds/incendiary
	cost = 4

/datum/uplink_item/ammo/sniper/disruptor
	name = ".50 BMG Disruptor Magazine"
	desc = "A 6-round magazine of disruptor ammo designed for use with .50 sniper rifles. \
			Put your enemies and their alarm clock to sleep today!"
	item = /obj/item/ammo_box/magazine/sniper_rounds/disruptor
	cost = 4

/datum/uplink_item/ammo/sniper/marksman
	name = ".50 BMG Marksman Magazine"
	desc = "A 6-round magazine of marksman ammo designed for use with .50 sniper rifles. \
			Blast your enemies with instant shots! Just watch out for the rebound..."
	item = /obj/item/ammo_box/magazine/sniper_rounds/marksman
	cost = 4

/datum/uplink_item/ammo/carbine
	name = "5.56mm Toploader Magazine"
	desc = "An additional 30-round 5.56mm magazine; suitable for use with the M-90gl carbine. \
			These bullets pack less punch than 7.12x82mm rounds, but they still offer more power than .45 ammo due to their innate armour penetration."
	item = /obj/item/ammo_box/magazine/m556
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/carbinephase
	name = "5.56mm Toploader Phasic Magazine"
	desc = "An additional 30-round 5.56mm magazine; suitable for use with the M-90gl carbine. \
			These bullets are made from an experimental alloy, 'Ghost Lead', that allows it to pass through almost any non-organic material. \
			The name is a misnomer. It doesn't contain any lead whatsoever!"
	item = /obj/item/ammo_box/magazine/m556/phasic
	cost = 8
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/machinegun
	cost = 6
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/machinegun/basic
	name = "7.12x82mm Box Magazine"
	desc = "A 50-round magazine of 7.12x82mm ammunition for use with the L6 SAW. \
			By the time you need to use this, you'll already be standing on a pile of corpses."
	item = /obj/item/ammo_box/magazine/mm712x82

/datum/uplink_item/ammo/machinegun/ap
	name = "7.12x82mm (Armor Penetrating) Box Magazine"
	desc = "A 50-round magazine of 7.12x82mm ammunition for use in the L6 SAW; equipped with special properties \
			to puncture even the most durable armor."
	item = /obj/item/ammo_box/magazine/mm712x82/ap
	cost = 9

/datum/uplink_item/ammo/machinegun/hollow
	name = "7.12x82mm (Hollow-Point) Box Magazine"
	desc = "A 50-round magazine of 7.12x82mm ammunition for use in the L6 SAW; equipped with hollow-point tips to help \
			with the unarmored masses of crew."
	item = /obj/item/ammo_box/magazine/mm712x82/hollow

/datum/uplink_item/ammo/machinegun/incen
	name = "7.12x82mm (Incendiary) Box Magazine"
	desc = "A 50-round magazine of 7.12x82mm ammunition for use in the L6 SAW; tipped with a special flammable \
			mixture that'll ignite anyone struck by the bullet. Some men just want to watch the world burn."
	item = /obj/item/ammo_box/magazine/mm712x82/incen

/datum/uplink_item/ammo/machinegun/match
	name = "7.12x82mm (Match) Box Magazine"
	desc = "A 50-round magazine of 7.12x82mm ammunition for use in the L6 SAW; you didn't know there was a demand for match grade \
			precision bullet hose ammo, but these rounds are finely tuned and perfect for ricocheting off walls all fancy-like."
	item = /obj/item/ammo_box/magazine/mm712x82/match
	cost = 10

/datum/uplink_item/ammo/rocket
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/rocket/basic
	name = "84mm HE Rocket"
	desc = "A low-yield anti-personnel HE rocket. Gonna take you out in style!"
	item = /obj/item/ammo_casing/caseless/rocket
	cost = 4

/datum/uplink_item/ammo/rocket/heap
	name = "84mm HEAP Rocket"
	desc = "A high-yield HEAP rocket; extremely effective against literally everything and anything near that thing that doesn't exist anymore. \
			Strike fear into the hearts of your enemies."
	item = /obj/item/ammo_casing/caseless/rocket/heap
	cost = 6

/datum/uplink_item/ammo/surplus_smg
	name = "Surplus SMG Magazine"
	desc = "A cylindrical magazine designed for the PP-95 SMG."
	item = /obj/item/ammo_box/magazine/plastikov9mm
	cost = 1
	purchasable_from = UPLINK_NUKE_OPS
	illegal_tech = FALSE

/datum/uplink_item/ammo/mech/bag
	name = "Mech Support Kit Bag"
	desc = "A duffel bag containing ammo for four full reloads of the scattershotm which is equipped on standard Dark Gygax exosuits. Also comes with some support equipment for maintaining the mech, including tools and an inducer. Contains a Bluespace Comprression kit for easier logistics."
	item = /obj/item/storage/backpack/duffelbag/syndie/ammo/mech
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/ammo/mauler/bag
	name = "Mauler Ammo Bag"
	desc = "A duffel bag containing ammo for three full reloads of the LMG and SRM-8 missile laucher that are equipped on a standard Mauler exosuit. Contains two Bluespace Comprression kits for easier logistics."
	item = /obj/item/storage/backpack/duffelbag/syndie/ammo/mauler
	cost = 8
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/explosives/bombanana
	name = "Bombanana"
	desc = "A banana with an explosive taste! discard the peel quickly, as it will explode with the force of a Syndicate minibomb \
		a few seconds after the banana is eaten."
	item = /obj/item/food/grown/banana/bombanana
	cost = 4 //it is a bit cheaper than a minibomb because you have to take off your helmet to eat it, which is how you arm it
	surplus = 60 //monkestation edit: from 0 to 60
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/explosives/clown_bomb_clownops
	name = "Clown Bomb"
	desc = "The Clown bomb is a hilarious device capable of massive pranks. It has an adjustable timer, \
		with a minimum of %MIN_BOMB_TIMER seconds, and can be bolted to the floor with a wrench to prevent \
		movement. The bomb is bulky and cannot be moved; upon ordering this item, a smaller beacon will be \
		transported to you that will teleport the actual bomb to it upon activation. Note that this bomb can \
		be defused, and some crew may attempt to do so."
	item = /obj/item/sbeacondrop/clownbomb
	cost = 15
	surplus = 0
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/explosives/clown_bomb_clownops/New()
	. = ..()
	desc = replacetext(desc, "%MIN_BOMB_TIMER", SYNDIEBOMB_MIN_TIMER_SECONDS)

/datum/uplink_item/explosives/buzzkill
	name = "Buzzkill Grenade Box"
	desc = "A box with three grenades that release a swarm of angry bees upon activation. These bees indiscriminately attack friend or foe \
			with random toxins. Courtesy of the BLF and Tiger Cooperative."
	item = /obj/item/storage/box/syndie_kit/bee_grenades
	cost = 15
	surplus = 35
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/explosives/virus_grenade
	name = "Fungal Tuberculosis Grenade"
	desc = "A primed bio-grenade packed into a compact box. Comes with five Bio Virus Antidote Kit (BVAK) \
			autoinjectors for rapid application on up to two targets each, a syringe, and a bottle containing \
			the BVAK solution."
	item = /obj/item/storage/box/syndie_kit/tuberculosisgrenade
	cost = 12
	surplus = 35
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	restricted = TRUE

/datum/uplink_item/explosives/grenadier
	name = "Grenadier's belt"
	desc = "A belt containing 26 lethally dangerous and destructive grenades. Comes with an extra multitool and screwdriver."
	item = /obj/item/storage/belt/grenade/full
	purchasable_from = UPLINK_NUKE_OPS
	cost = 22
	surplus = 70 //monkestation edit: from 0 to 70

/datum/uplink_item/explosives/syndicate_detonator
	name = "Syndicate Detonator"
	desc = "The Syndicate detonator is a companion device to the Syndicate bomb. Simply press the included button \
			and an encrypted radio frequency will instruct all live Syndicate bombs to detonate. \
			Useful for when speed matters or you wish to synchronize multiple bomb blasts. Be sure to stand clear of \
			the blast radius before using the detonator."
	item = /obj/item/syndicatedetonator
	cost = 3
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/explosives/tearstache
	name = "Teachstache Grenade"
	desc = "A teargas grenade that launches sticky moustaches onto the face of anyone not wearing a clown or mime mask. The moustaches will \
		remain attached to the face of all targets for one minute, preventing the use of breath masks and other such devices."
	item = /obj/item/grenade/chem_grenade/teargas/moustache
	cost = 3
	surplus = 80 //monkestation edit: from 0 to 80
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/explosives/viscerators
	name = "Viscerator Delivery Grenade"
	desc = "A unique grenade that deploys a swarm of viscerators upon activation, which will chase down and shred \
			any non-operatives in the area."
	item = /obj/item/grenade/spawnergrenade/manhacks
	cost = 5
	surplus = 35
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/dangerous/syndicat
	name = "Syndie cat grenade"
	desc = "This grenade is filled with 3 trained angry cats in special syndicate modsuits. Upon activation, the Syndicate cats are awoken and unleashed unto unlucky bystanders."
	item = /obj/item/grenade/spawnergrenade/cat/syndicate
	cost = 20
	surplus = 50
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/explosives/pinata
	name = "Weapons Grade Pinata Kit"
	desc = "A pinata filled with both candy and explosives as well as two belts to carry them on, crack it open and see what you get!"
	item = /obj/item/storage/box/syndie_kit/pinata
	purchasable_from = UPLINK_CLOWN_OPS
	limited_stock = 1
	cost = 12 //This is effectively the clown ops version of the grenadier belt where you should on average get 8 explosives if you use a weapon with exactly 10 force.
	surplus = 60 //monkestation edit: from 0 to 60

//Support and Mechs
/datum/uplink_category/support
	name = "Support and Exosuits"
	weight = 5

/datum/uplink_item/support
	category = /datum/uplink_category/support
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/support/clown_reinforcement
	name = "Clown Reinforcements"
	desc = "Call in an additional clown to share the fun, equipped with full starting gear, but no telecrystals."
	item = /obj/item/antag_spawner/nuke_ops/clown
	cost = 20
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/support/reinforcement
	name = "Reinforcements"
	desc = "Call in an additional team member from one of our factions. \
		They'll come equipped with a mere surplus SMG, so arming them is recommended."
	item = /obj/item/antag_spawner/nuke_ops
	cost = 25
	purchasable_from = UPLINK_NUKE_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/support/reinforcement/assault_borg
	name = "Syndicate Assault Cyborg"
	desc = "A cyborg designed and programmed for systematic extermination of non-Syndicate personnel. \
			Comes equipped with a self-resupplying LMG, a grenade launcher, energy sword, emag, pinpointer, flash and crowbar."
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/assault
	cost = 65
	restricted = TRUE

/datum/uplink_item/support/reinforcement/medical_borg
	name = "Syndicate Medical Cyborg"
	desc = "A combat medical cyborg. Has limited offensive potential, but makes more than up for it with its support capabilities. \
			It comes equipped with a nanite hypospray, a medical beamgun, combat defibrillator, full surgical kit including an energy saw, an emag, pinpointer and flash. \
			Thanks to its organ storage bag, it can perform surgery as well as any humanoid."
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/medical
	cost = 35
	restricted = TRUE

/datum/uplink_item/support/reinforcement/saboteur_borg
	name = "Syndicate Saboteur Cyborg"
	desc = "A streamlined engineering cyborg, equipped with covert modules. Also incapable of leaving the welder in the shuttle. \
			Aside from regular Engineering equipment, it comes with a special destination tagger that lets it traverse disposals networks. \
			Its chameleon projector lets it disguise itself as a Nanotrasen cyborg, on top it has thermal vision and a pinpointer."
	item = /obj/item/antag_spawner/nuke_ops/borg_tele/saboteur
	cost = 35
	restricted = TRUE

/datum/uplink_item/support/gygax
	name = "Dark Gygax Exosuit"
	desc = "A lightweight exosuit, painted in a dark scheme. Its speed and equipment selection make it excellent \
			for hit-and-run style attacks. Features a scattershot shotgun, armor boosters against melee and ranged attacks, ion thrusters and a Tesla energy array."
	item = /obj/vehicle/sealed/mecha/gygax/dark/loaded
	cost = 80
	surplus = 40

/datum/uplink_item/support/honker
	name = "Dark H.O.N.K."
	desc = "A clown combat mech equipped with bombanana peel and tearstache grenade launchers, as well as the ubiquitous HoNkER BlAsT 5000."
	item = /obj/vehicle/sealed/mecha/honker/dark/loaded
	cost = 80
	surplus = 60
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/support/mauler
	name = "Mauler Exosuit"
	desc = "A massive and incredibly deadly military-grade exosuit. Features long-range targeting, thrust vectoring \
			and deployable smoke. Comes equipped with an LMG, scattershot carbine, missile rack, an antiprojectile armor booster and a Tesla energy array."
	item = /obj/vehicle/sealed/mecha/marauder/mauler/loaded
	cost = 140

/datum/uplink_item/support/devitt
	name = "Devitt Mk3 Light Tank"
	desc = "An ancient tank found in the wearhouse, comes prepared with a cannon and machinegun. REQUIRES TWO CREWMEMBERS TO OPPERATE EFFECTIVELY."
	item = /obj/vehicle/sealed/mecha/devitt
	cost = 80

/datum/uplink_item/support/lighttankammo
	name = "40mm cannon ammo"
	desc = "5 crated shells for use with the Devitt Mk3 light tank."
	item = /obj/item/mecha_ammo/makeshift/lighttankammo
	cost = 2

/datum/uplink_item/support/lighttankmgammo
	name = "12.7x70mm tank mg ammo"
	desc = "60 rounds of 12.7x70mm for use with the Devitt Mk3 light tank."
	item = /obj/item/mecha_ammo/makeshift/lighttankmg
	cost = 1

/datum/uplink_item/support/turretbox
	name = "Disposable Sentry Gun"
	desc = "A disposable sentry gun deployment system cleverly disguised as a toolbox, apply wrench for functionality."
	item = /obj/item/storage/toolbox/emergency/turret/nukie
	cost = 16

/datum/uplink_item/stealthy_tools/combatbananashoes
	name = "Combat Banana Shoes"
	desc = "While making the wearer immune to most slipping attacks like regular combat clown shoes, these shoes \
		can generate a large number of synthetic banana peels as the wearer walks, slipping up would-be pursuers. They also \
		squeak significantly louder."
	item = /obj/item/clothing/shoes/clown_shoes/banana_shoes/combat
	cost = 6
	surplus = 100 //monkestation edit: from 0 to 100 HONK
	purchasable_from = UPLINK_CLOWN_OPS

/datum/uplink_item/stealthy_tools/syndigaloshes/nuke
	item = /obj/item/clothing/shoes/chameleon/noslip
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/suits/modsuit/elite
	name = "Elite Syndicate MODsuit"
	desc = "An upgraded, elite version of the Syndicate MODsuit. It features fireproofing, and also \
			provides the user with superior armor and mobility compared to the standard Syndicate MODsuit."
	item = /obj/item/mod/control/pre_equipped/elite
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/suits/energy_shield
	name = "MODsuit Energy Shield Module"
	desc = "An energy shield module for a MODsuit. The shields can handle up to three impacts \
			within a short duration and will rapidly recharge while not under fire."
	item = /obj/item/mod/module/energy_shield
	cost = 15
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/suits/emp_shield
	name = "MODsuit Advanced EMP Shield Module"
	desc = "An advanced EMP shield module for a MODsuit. It protects your entire body from electromagnetic pulses."
	item = /obj/item/mod/module/emp_shield/advanced
	cost = 5
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/suits/injector
	name = "MODsuit Injector Module"
	desc = "An injector module for a MODsuit. It is an extendable piercing injector with 30u capacity."
	item = /obj/item/mod/module/injector
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/suits/holster
	name = "MODsuit Holster Module"
	desc = "A holster module for a MODsuit. It can stealthily store any not too heavy gun inside it."
	item = /obj/item/mod/module/holster
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/assault_pod
	name = "Assault Pod Targeting Device"
	desc = "Use this to select the landing zone of your assault pod."
	item = /obj/item/assault_pod
	cost = 30
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	restricted = TRUE

/datum/uplink_item/device_tools/syndie_jaws_of_life
	name = "Syndicate Jaws of Life"
	desc = "Based on a Nanotrasen model, this powerful tool can be used as both a crowbar and a pair of wirecutters. \
	In its crowbar configuration, it can be used to force open airlocks. Very useful for entering the station or its departments."
	item = /obj/item/crowbar/power/syndicate
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/medgun
	name = "Medbeam Gun"
	desc = "A wonder of Syndicate engineering, the Medbeam gun, or Medi-Gun enables a medic to keep his fellow \
			operatives in the fight, even while under fire. Don't cross the streams!"
	item = /obj/item/gun/medbeam
	cost = 15
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/medkit
	name = "Syndicate Combat Medic Kit"
	desc = "This first aid kit is a suspicious black and red. Included is a number of atropine medipens \
			for rapid stabilization and detonation prevention, sutures and regenerative mesh for wound treatment, and patches \
			for faster healing on the field. Also comes with basic medical tools and sterlizer."
	item = /obj/item/storage/medkit/tactical
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/medkit/premium
	name = "Syndicate Combat Medical Suite"
	desc = "This first aid kit is a suspicious black and red. Included is an unloaded combat chemical injector \
			for suit-penetrative chem delivery, a medical science night vision HUD for quick identification of injured personnel and chemical supplies, \
			improved medical supplies, including Interdyne-approved pharmaceuticals, a hacked cybernetic surgery toolset arm implant, \
			and some helpful MODsuit modules for for field medical use and operative physiopharmaceutical augmentation."
	item = /obj/item/storage/medkit/tactical/premium
	cost = 15
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS

/datum/uplink_item/device_tools/potion
	name = "Syndicate Sentience Potion"
	item = /obj/item/slimepotion/slime/sentience/nuclear
	desc = "A potion recovered at great risk by undercover Syndicate operatives and then subsequently modified with Syndicate technology. \
			Using it will make any animal sentient, and bound to serve you, as well as implanting an internal radio for communication and an internal ID card for opening doors."
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	restricted = TRUE

/datum/uplink_item/implants/antistun
	name = "CNS Rebooter Implant"
	desc = "This implant will help you get back up on your feet faster after being stunned. Comes with an autosurgeon."
	item = /obj/item/storage/box/syndie_kit/anti_stun
	cost = 12
	surplus = 40 //monkestation edit: from 0 to 40
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/microbomb
	name = "Microbomb Implant"
	desc = "An implant injected into the body, and later activated either manually or automatically upon death. \
			The more implants inside of you, the higher the explosive power. \
			This will permanently destroy your body, however."
	item = /obj/item/storage/box/syndie_kit/imp_microbomb
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/macrobomb
	name = "Macrobomb Implant"
	desc = "An implant injected into the body, and later activated either manually or automatically upon death. \
			Upon death, releases a massive explosion that will wipe out everything nearby."
	item = /obj/item/storage/box/syndie_kit/imp_macrobomb
	cost = 20
	purchasable_from = UPLINK_NUKE_OPS
	restricted = TRUE

/datum/uplink_item/implants/reviver
	name = "Reviver Implant"
	desc = "This implant will attempt to revive and heal you if you lose consciousness. Comes with an autosurgeon."
	item = /obj/item/storage/box/syndie_kit/reviver
	cost = 8
	surplus = 30 //monkestation edit: from 0 to 30
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/implants/deathrattle
	name = "Box of Deathrattle Implants"
	desc = "A collection of implants (and one reusable implanter) that should be injected into the team. When one of the team \
	dies, all other implant holders recieve a mental message informing them of their teammates' name \
	and the location of their death. Unlike most implants, these are designed to be implanted \
	in any creature, biological or mechanical."
	item = /obj/item/storage/box/syndie_kit/imp_deathrattle
	cost = 4
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS

/datum/uplink_item/badass/costumes
	surplus = 0
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	cost = 4
	cant_discount = TRUE

/datum/uplink_item/badass/clownopclumsinessinjector //clowns can buy this too, but it's in the role-restricted items section for them
	name = "Clumsiness Injector"
	desc = "Inject yourself with this to become as clumsy as a clown... or inject someone ELSE with it to make THEM as clumsy as a clown. Useful for clown operatives who wish to reconnect with their former clownish nature or for clown operatives who wish to torment and play with their prey before killing them."
	item = /obj/item/dnainjector/clumsymut
	cost = 1
	purchasable_from = UPLINK_CLOWN_OPS
	illegal_tech = FALSE

/datum/uplink_item/stealthy_weapons/romerol_kit
	name = "Romerol"
	desc = "A highly experimental bioterror agent which creates dormant nodules to be etched into the grey matter of the brain. \
			On death, these nodules take control of the dead body, causing limited revivification, \
			along with slurred speech, aggression, and the ability to infect others with this agent."
	item = /obj/item/storage/box/syndie_kit/romerol
	cost = 25
	purchasable_from = UPLINK_CLOWN_OPS|UPLINK_NUKE_OPS
	cant_discount = TRUE
	surplus = 10 //very rare from lootboxes

/datum/uplink_item/support/bomb_key
	name = "Syndicate Ordnance Laboratory Access Card"
	desc = "Do you fancy yourself an explosives expert? If so, then consider yourself lucky! With this special Authorization Key, \
			you can blow those corpo suits away with your very own home-made explosive devices. Made in your local firebase's \
			very own Ordnance Laboratory! *The Syndicate is not responsible for injuries or deaths sustained while utilizing the lab."
	item = /obj/item/keycard/syndicate_bomb
	cost = 15
	purchasable_from = UPLINK_NUKE_OPS
	cant_discount = TRUE

/datum/uplink_item/support/bio_key
	name = "Syndicate Bio-Weapon Laboratory Access Card"
	desc = "In the right hands, even vile corpo technology can be turned into a vast arsenal of liberation and justice. From \
			micro-organism symbiosis to slime-core weaponization, this special Authorization Key can let you push past the boundaries \
			of bio-terrorism at breakneck speeds. As a bonus, these labs even come equipped with natural life support! *Plants not included."
	item = /obj/item/keycard/syndicate_bio
	cost = 17
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_NUKE_OPS
	cant_discount = TRUE

/datum/uplink_item/support/chem_key
	name = "Syndicate Chemical Plant Access Card"
	desc = "For some of our best Operatives, watching corpo space stations blow up with a flash of retribution just isn't enough. \
			Folks like those prefer a more personal touch to their artistry. For those interested, a special Authorization Key \
			can be instantly delivered to your location. Create groundbreaking chemical agents, cook up, sell the best of drugs, \
			and listen to the best classic music today!"
	item = /obj/item/keycard/syndicate_chem
	cost = 12
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_NUKE_OPS
	cant_discount = TRUE

/datum/uplink_item/support/fridge_key
	name = "Lopez's Access Card"
	desc = "Hungry? So is everyone in Firebase Balthazord. Lopez is a great cook, don't get me wrong, but he's stubborn when it \
			comes to the meal plans. Sometimes you just want to pig out. Listen, don't tell anyone, ok? I picked this out of his \
			pocket during this morning's briefing. He's been looking for it since. Take it, get into the fridge, and cook up whatever \
			you need before he gets back. And remember: DON'T TELL ANYONE! -M.T"
	item = /obj/item/keycard/syndicate_fridge
	cost = 5
	purchasable_from = UPLINK_CLOWN_OPS | UPLINK_NUKE_OPS

/datum/uplink_item/suits/cybersun_juggernaut_suit
	name = "Cybersun Juggernaut Minigun Combo and Suit Access Card"
	desc = "Developed by Cybersun for use in clearing heavy space bear infestations in asteroid belt operations.\
	It now has a new purpose as the heavy operation suit of the Syndicate. By purchasing this you get a special Authorization Key to the only suit in storage at Firebase Balthazord."
	item = /obj/item/keycard/syndicate_suit_storage
	cost = 35
	purchasable_from = UPLINK_NUKE_OPS
	limited_stock = 1

/datum/uplink_item/stealthy_tools/amogus_potion
	name = "Mysterious potion"
	desc = "A strange red potion that's said to turn you into a tiny red space man at 3AM, seems to work at any time though. \
			Drinking this potion will turn you very small allowing you to be carried in backpacks by your fellow operatives, \
			seems to not make goblins or monkeys any smaller though. No money refunds."
	purchasable_from = UPLINK_NUKE_OPS | UPLINK_CLOWN_OPS
	item = /obj/item/amogus_potion
	cost = 7

/datum/uplink_item/ammo/LMG
	name = "6.5 FMJ Quarad drum"
	desc = "A surplus 120 round drum of FMJ bullets for the Quarad"
	item = /obj/item/ammo_box/magazine/c65xeno_drum/evil
	cost = 2
	purchasable_from = UPLINK_NUKE_OPS
	illegal_tech = FALSE

/datum/uplink_item/ammo/LMG/incendiary
	name = "6.5 Inferno Quarad drum"
	desc = "A 120 round drum of Inferno bullets for the Quarad. They leave a trail of fire"
	item = /obj/item/ammo_box/magazine/c65xeno_drum/incendiary/evil
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS
	illegal_tech = FALSE

/datum/uplink_item/ammo/LMG/pierce
	name = "6.5 UDS Quarad drum"
	desc = "No, NOT depleted uranium. 120 round drum of piercing and irradiating bullets for the Quarad"
	item = /obj/item/ammo_box/magazine/c65xeno_drum/pierce/evil
	cost = 4
	purchasable_from = UPLINK_NUKE_OPS
	illegal_tech = FALSE

/datum/uplink_item/dangerous/Evil_Quarad
	name = "Syndicate-Enhanced Light Suppression Weapon"
	desc = "A heavily modified Quarad LMG, complete with bluespace barrel extender and retooled recoil reduction. Takes 120 round drums, good for suppressive fire."
	item = /obj/item/gun/ballistic/automatic/quarad_lmg/evil
	cost = 16
	purchasable_from = UPLINK_NUKE_OPS
	illegal_tech = FALSE

/datum/uplink_item/implants/hardlight/max
	name = "Commanding Hardlight Spear Implant"
	desc = "An implant that allows you to summon and control seven hardlight spears. \
	Additional implants will do nothing, you cannot improve on perfection. Side effects may include: Uncontrollable telepathy, formation of subconscious hiveminds, anamnesis, levitation, and hallucinations of music. \
	Aetherofusion is not responsable for any damages this may cause."
	purchasable_from = UPLINK_NUKE_OPS
	item = /obj/item/storage/box/syndie_kit/imp_hard_spear/max
	cost = 35

/datum/uplink_item/reinforcement/monkey_agent
	name = "Simian Agent Reinforcements"
	desc = "Call in an extremely well trained monkey secret agent from our Syndicate Banana Department. \
		They've been trained to operate machinery and can read, but they can't speak Common."
	item = /obj/item/antag_spawner/loadout/monkey_man
	cost = 7
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

/datum/uplink_item/reinforcement/monkey_supplies
	name = "Simian Agent Supplies"
	desc = "Sometimes you need a bit more firepower than a rabid monkey. Such as a rabid, armed monkey! \
		Monkeys can unpack this kit to recieve a bag with a bargain-bin gun, ammunition, and some miscellaneous supplies."
	item = /obj/item/storage/toolbox/guncase/monkeycase
	cost = 4
	purchasable_from = UPLINK_CLOWN_OPS
	restricted = TRUE
	refundable = TRUE

