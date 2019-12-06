export const VALIDATE_FIRST_STEP_REQUESTED = 'VALIDATE_FIRST_STEP_REQUESTED';
export const validateFirstStepRequest = (formStep, type) => ({
    type: VALIDATE_FIRST_STEP_REQUESTED,
    payload: { formStep, type },
});

export const VALIDATE_FIRST_STEP_SUCCEEDED = 'VALIDATE_FIRST_STEP_SUCCEEDED';
export const validateFirstStepSuccess = () => ({
    type: VALIDATE_FIRST_STEP_SUCCEEDED,
});

export const VALIDATE_FIRST_STEP_FAILED = 'VALIDATE_FIRST_STEP_FAILED';
export const validateFirstStepFail = () => ({
    type: VALIDATE_FIRST_STEP_FAILED,
});
