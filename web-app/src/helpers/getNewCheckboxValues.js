export const getNewCheckboxValues = (oldValues, selectedValue) => {
    if (oldValues.includes(selectedValue)) {
        return oldValues.filter(oldValue => oldValue !== selectedValue);
    }
    return [...oldValues, selectedValue];
};
