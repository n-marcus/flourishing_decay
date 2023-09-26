import { writable } from 'svelte/store';

export const currentBeeIndex = writable(0);

export const crossFading = writable(false);

export const beePercentage = writable(0)
