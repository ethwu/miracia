import { DSVRowArray, tsvParse } from '/node_modules/d3-dsv';

// import thresholds_data from '/static/xp_thresholds_by_character_level.tsv';

const thresholds_data = new URL('/static/xp_thresholds_by_character_level.tsv', import.meta.url)

const CharacterLevel = 'Character Level';
enum EncounterDifficulty {
    Easy = 'Easy',
    Medium = 'Medium',
    Hard = 'Hard',
    Deadly = 'Deadly',
}

/** XP thresholds for a given character level. */
interface XpThreshold {
    [CharacterLevel]: number;
    [EncounterDifficulty.Easy]: number;
    [EncounterDifficulty.Medium]: number;
    [EncounterDifficulty.Hard]: number;
    [EncounterDifficulty.Deadly]: number;
};


/**
 * Get the appropriate XP threshold for the given character at the given
 * difficulty level. Assumes that the data file contains the appropriate
 * thresholds, numbered sequentially from one and listed in order of level.
 * @param level The character's level.
 * @param difficulty The encounter difficulty.
 * @returns The XP threshold for an encounter with this character.
 */
function xp_threshold_for_character(
    thresholds: DSVRowArray<EncounterDifficulty>,
    level: number,
    difficulty: EncounterDifficulty
): number {
    if (level > thresholds.length) return null;

    return thresholds[level - 1][difficulty] as unknown as number;
}

(async function () {
    const r: Response = await fetch(thresholds_data);

    if (r.status !== 200) return;

    /** XP Thresholds */
    const thresholds: DSVRowArray<EncounterDifficulty> = tsvParse(await r.text());

    console.log(
        xp_threshold_for_character(thresholds, 12, EncounterDifficulty.Hard)
    );
})();
