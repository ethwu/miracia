import { DSVRowArray, tsvParse } from 'd3-dsv';

import spell_slot_data from '/static/spell_slots.tsv';


/** A tuple listing a count of spell slots of levels 1--9. */
type SpellSlots = [
    number,
    number,
    number,
    number,
    number,
    number,
    number,
    number,
    number
];

/** Get the point cost of a spell from its level. */
function point_cost(spell_level: number): number {
    return (spell_level <= 3 ? Math.ceil : Math.floor)(spell_level * 1.5);
}

/** Convert spell slots to spell points. */
function spell_points(slots: SpellSlots): number {
    return slots
        .map((el, index) => el * point_cost(index)])
        .reduce((partial, el) => partial + el);
}

/** Get the number of spell points to recover. */
function recover_points(level: number): number {
    return Math.ceil(11 * Math.ceil(level / 2) / 8);
}

