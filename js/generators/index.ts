
import { Card } from './card';
import { Character } from './character';
import { Npc } from './npc';

/** Add cards to a given section. */
function add_cards(
    section: string,
    CardType: new (...args: any[]) => Card<any>,
    count: number
): void {
    const card_container = document.querySelector(section);
    for (let i = 0; i < count; i++) {
        card_container.appendChild(new CardType().to_html());
    }
}

add_cards('#characters', Character, 6);
add_cards('#npcs', Npc, 6);
