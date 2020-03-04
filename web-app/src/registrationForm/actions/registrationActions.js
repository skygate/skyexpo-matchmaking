export const VALIDATE_STEP_OF_FORM_REQUESTED = 'VALIDATE_STEP_OF_FORM_REQUESTED';
export const validateStepOfFormRequest = (formValues, userType, step) => ({
    type: VALIDATE_STEP_OF_FORM_REQUESTED,
    payload: { formValues, userType, step },
});

export const VALIDATE_STEP_OF_FORM_PASS_SUCCEEDED = 'VALIDATE_STEP_OF_FORM_PASS_SUCCEEDED';
export const validateStepOfFormPassSuccess = (userType, step) => ({
    type: VALIDATE_STEP_OF_FORM_PASS_SUCCEEDED,
    payload: { userType, step },
});

export const VALIDATE_STEP_OF_FORM_ERRORS_SUCCEEDED = 'VALIDATE_STEP_OF_FORM_ERRORS_SUCCEEDED';
export const validateStepOfFormErrorsSuccess = (validationErrors, userType, step) => ({
    type: VALIDATE_STEP_OF_FORM_ERRORS_SUCCEEDED,
    payload: { validationErrors, userType, step },
});

export const VALIDATE_STEP_OF_FORM_FAILED = 'VALIDATE_STEP_OF_FORM_FAILED';
export const validateStepOfFormFail = (validationErrors, userType, step) => ({
    type: VALIDATE_STEP_OF_FORM_FAILED,
    payload: { validationErrors, userType },
});
