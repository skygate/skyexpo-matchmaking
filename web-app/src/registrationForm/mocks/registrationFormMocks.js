export const saveStepFormRequestPayload = {
    userType: 'startup',
    formValues: { name: 'testName' },
};

export const validateRequestPayload = {
    ...saveStepFormRequestPayload,
    step: 1,
};
