import { Names } from "fantasy-content-generator";
import { INameDomainObject } from "fantasy-content-generator/dist/interfaces";
import { Card } from "./card";

export class Character extends Card<INameDomainObject> {
    constructor(data?: INameDomainObject) {
        super();
        this.data = data ?? this.generate_data();
    }

    generate_data(): INameDomainObject {
        return Names.generate();
    }

    refresh_data(): void {
        this.data = this.generate_data();
    }

    template(): string {
        return `
<header>
    <h1>${this.data.formattedData.name}</h1>
    <p class="subtitle">
        ${this.data.formattedData.gender} ${this.data.formattedData.race}
    </p>
</header>
<main></main>
<footer>${this.data.seed}</footer>`;
    }
}
