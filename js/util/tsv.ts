import { DSVRowArray, tsvParse } from 'd3-dsv';

/** Load TSV data from a given URL. */
export async function load_data(url: string): Promise<DSVRowArray<string>> {
    const r: Response = await fetch(url);
    if (r.status !== 200) return;

    return tsvParse(await r.text());
}
