
import '/css/generators/card.less';

/** Generator card. */
export abstract class Card<T> {
    /** Data store for this item. */
    data: T;
    /** Generate random data for this item. */
    abstract generate_data(): T;
    /** Refresh the data for this item. */
    abstract refresh_data(): void;
    /** Get the formatted template for this item. */
    abstract template(): string;
    /** Generate an HTML card for this item. */
    to_html(): HTMLElement {
        const card = document.createElement('div');
        card.classList.add('card');
        card.innerHTML = this.template();

        card.onclick = (e) => {
            this.refresh_data();
            card.innerHTML = this.template();
        };
        return card;
    }
}
