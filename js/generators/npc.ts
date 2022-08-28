import { NPCs } from 'fantasy-content-generator';
import { INPCDomainObject } from 'fantasy-content-generator/dist/interfaces';

import { Card } from './card';

export class Npc extends Card<INPCDomainObject> {
    constructor(data?: INPCDomainObject) {
        super();
        this.data = data ?? this.generate_data();
    }

    generate_data(): INPCDomainObject {
        return NPCs.generate({ shouldGenerateRelations: true });
    }

    refresh_data(): void {
        this.data = this.generate_data();
    }

    template(): string {
        const fd = this.data.formattedData;
        const vocation = this.data.vocation ? ' ' + fd.vocation : '';
        console.log(fd.desires.length, fd.traits.length, fd.relations.length);
        let out = `
<header>
    <h1>${fd.name}</h1>
    <p class="subtitle">
        ${fd.gender} ${fd.race}${vocation}
    </p>
</header>
<main>
    <section>
        <header><h2>Traits</h2></header>
        ${fd.traits.join(' ')}
    </section>
    <section>
        <header><h2>Desires</h2></header>
        ${fd.desires.join(' ')}
    </section>
    <section>`;

        if (this.data.relations.length > 0) {
            out += '<header><h2>Relations</h2></header><dl>';
            for (const relation of fd.relations) {
                out += `<dt>${relation.relationTitle}</dt>
                <dd>${relation.npc.formattedData.name}</dd>`;
            }
        }

        return (
            out +
            `
</section>
</main>
<footer>${this.data.seed}</footer>`
        );
    }
}
