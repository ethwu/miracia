#lang pollen

@title{Magic}

@section["Overview"]{
    Magic does not flow freely in Miracia, as it does in other worlds. Instead, all magic relies on the magical essence, @emph{aure}@sidenote{@emph{Aure}, literally "breath", is typically found as a gas, particularly in pockets embedded within Miracia's floating islands.}. While aure occurs naturally as a gas, it is easiest to work with in its liquid form, @emph{ahjari}@sidenote{"water of life"}, which is in turn either pumped through pipelines to power civic infrastructure or packaged in canisters for portable use. Portable artifices must be powered using these canisters, and nearly all casters@sidenote{The priests of the Order of Hunyil do not carry canisters.} will carry a supply in order to fuel their magic.

    The supply of readily available aure dwindles as the Auremic Revolution continues, driving the price of the invaluable resource upwards. While mining operations on the surface of the continent Avrasol@sidenote{"great continent"} provided the initial supply of aure, it was soon discovered that aure mining destabilized islands by removing the buoyant gas holding them afloat. This led to the now-widespread practice of capturing smaller islands and establishing mining towns on them, extracting aure until the island collapses into the Abyss.@sidenote{Other means of aure collection exist, including the use of @emph{auremic condensers}, which extract naturally occuring aure from the air. Auremic condensers are, however, not capable of yielding enough aure to feed the world's technological appetite.}

    Most casters in Miracia tend to be young. It is exceedingly rare to see an elderly caster. Those who do reach advanced age are widely looked up to for their wisdom, and are usually in positions of power and influence.

    @figure{
        @tsv{
Type	Class	Life Expectancy
Non-Caster	Barbarian	80
 	Fighter	
 	Monk	
 	Rogue	
Third-Caster	Rogue (Arcane Trickster)	64
 	Fighter (Eldritch Knight)	
Half-Caster	Artificer	48
 	Paladin	
 	Ranger	
Full Caster	Bard	32
 	Cleric	
 	Druid	
 	Sorcerer	
 	Wizard	
Pact Caster	Warlock	24
        }
        @caption{Average Human Life Expectancy for Magic Users}
    }
}

@section["Recovering Spell Slots"]{
    No creature can naturally recover spell slots by taking a Long Rest. Instead, spell slots are regained by harmonizing with an ahjari canister@sidenote{An @emph{ahjari canister} has AC 15 and 10 hit points, and weighs 0.25 lb. It contains one quart of Ahjari. If it falls to zero hit points, it detonates, dealing radiant damage to all creatures within a 15 ft radius. according to the Ahjari Canister Damage table below. Any creature within the blast radius may choose to dodge the explosion by making a Dexterity saving throw. The spell points that would have been restored by the canister when used normally are instead spread evenly between all creatures who take damage from the blast but are not killed or incapacitated, rounded down. Depleted canisters do not explode and will not restore spell points.}.

    @margin-figure{
        @tsv{
            Quality	Save DC	Damage
            Raw	10	2d10
            Condensed	12	4d10
            Refined	15	10d10
            Pure	20	18d10
        }
        @caption{Ahjari Canister Damage}
    }

    A creature may regain spell slots by taking the Harmonize action while in possession of an ahjari canister. Harmonizing with a canister takes twelve seconds of focus. On the first use of the Harmonize action, the creature begins harmonizing with the canister. If the creature takes any damage while harmonizing, the process is interrupted and no spell slots are regained. After the second use of the Harmonize action, if the creature does not take damage before the beginning of its next turn, it regains spell slots as shown in Maximum Spell Slots or Spell Points Recovered. Regardless of whether any spell slots were recovered, the canister is depleted.

    There are four grades of ahjari: raw, condensed, refined, and pure. One quart of ahjari of each grade will restore spent spell slots up to the number of spell slots available to the caster at levels 4, 10, 17, or 20, respectively.@sidenote{Harmonizing with ahjari of any grade will not restore more spell slots or spell points than the caster has already spent, nor will it allow the caster to have more spell slots or spell points than they are normally allowed at their current level.} Alternatively, it restores up to 17, 64, 107, or 133 spent spell points.

    @figure{
        @tsv{
            Quality	Spell Slots	Spell Points
            Raw	All Available at Level 4	17
            Condensed	All Available at Level 10	64
            Refined	All Available at Level 17	107
            Pure	All Available at Level 20	133
        }
        @caption{Maximum Spell Slots or Spell Points Recovered}
    }

    @subsection["Restoring Spell Slots without Ahjari"]{
        It is possible to restore spell slots without an ahjari canister by focusing one's internal energy. During a Short or Long Rest where you would normally regain spell slots, you can restore a number of spell slots corresponding to a particular grade of ahjari at the cost of one level of Exhaustion@sidenote{While Exhausted, you take a penalty to d20 Tests and save DCs that you inflict equal to your current Exhaustion level. Finishing a Long Rest removes one level of Exhaustion. You die if your Exhaustion Level reaches 10. You are no longer Exhausted once your Exhaustion level falls to 0.} per tier.


        @figure{
            @tsv{
                Exhaustion Incurred	Spell Slots	Spell Points
                1	All Available at Level 4	17
                2	All Available at Level 10	64
                3	All Available at Level 17	107
                4	All Available at Level 20	133
            }
            @caption{Maximum Spell Slots or Spell Points Recovered Without Ahjari}
        }
    }

    @subsection["Sorcerers"]{
        Sorcerers may convert sorcery points to spell slots as usual. However, sorcery points will not recover on Long Rests. A Sorcerer will recover all of their Sorcery Points after harmonizing with an ahjari canister of any grade.
    }

    @subsection["Warlocks"]{
        Warlocks will not recover spell slots on Shorts Rests. However, Warlocks only require one use of the Harmonize action in order to harmonize with an ahjari canister. After a single use of the Harmonize action, if the Warlock takes no damage before the start of their next turn, they regain all of their spell slots at the beginning of their next turn.
    }

    @subsection["Restrictions on Ahjari"]{
        @margin-figure{
            @tsv{
                Quality	Price
                Raw	50 gp
                Condensed	100 gp
                Refined	500 gp
                Pure	1000 gp
            }
            @caption{Cost of an Ahjari Canister}
        }

        Because of ahjari's increasing scarcity and importance for civic infrastructure and defense, authorities generally prohibit any person from carrying or otherwise transporting more than three gallons of ahjari without a license.
    }
}

@script{/js/spells/index.ts}
