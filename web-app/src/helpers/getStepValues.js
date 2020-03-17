export const getStepValues = (stepInputs, formData) => {
    const condition = stepInputs.map(a => a.name);

    return Object.keys(formData)
        .filter(value => condition.includes(value))
        .reduce(
            (obj, key) => ({
                ...obj,
                [key]: formData[key],
            }),
            {},
        );
};
