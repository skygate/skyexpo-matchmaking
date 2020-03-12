import { countryList } from '../config/countryList';

export const countryOptions = countryList.map(({ name, code }) => ({
    label: name,
    value: code,
}));
