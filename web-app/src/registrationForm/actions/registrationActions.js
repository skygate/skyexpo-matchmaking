export const VALIDATE_STEP_OF_FORM_REQUESTED = 'VALIDATE_STEP_OF_FORM_REQUESTED';
export const validateStepOfFormRequest = ({
    formValues,
    userType,
    step,
    isPassingFrontValidation,
}) => ({
    type: VALIDATE_STEP_OF_FORM_REQUESTED,
    payload: { formValues, userType, step, isPassingFrontValidation },
});

export const VALIDATE_STEP_OF_FORM_PASS_SUCCEEDED = 'VALIDATE_STEP_OF_FORM_PASS_SUCCEEDED';
export const validateStepOfFormPassSuccess = ({ userType, isPassingFrontValidation }) => ({
    type: VALIDATE_STEP_OF_FORM_PASS_SUCCEEDED,
    payload: { userType, isPassingFrontValidation },
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

export const SAVE_STEP_FORM_ANSWERS_REQUESTED = 'SAVE_STEP_FORM_ANSWERS_REQUESTED';
export const saveStepFormAnswersRequest = (formValues, userType, step) => ({
    type: SAVE_STEP_FORM_ANSWERS_REQUESTED,
    payload: { formValues, userType, step },
});

export const SAVE_STEP_FORM_ANSWERS_SUCCEEDED = 'SAVE_STEP_FORM_ANSWERS_SUCCEEDED';
export const saveStepFormAnswersSuccess = (userType, step) => ({
    type: SAVE_STEP_FORM_ANSWERS_SUCCEEDED,
    payload: { userType, step },
});

export const SAVE_STEP_FORM_ANSWERS_FAILED = 'SAVE_STEP_FORM_ANSWERS_FAILED';
export const saveStepFormAnswersFail = (validationErrors, userType, step) => ({
    type: SAVE_STEP_FORM_ANSWERS_FAILED,
    payload: { validationErrors, userType },
});

export const SET_STEP_OF_REGISTRATION_FORM = 'SET_STEP_OF_REGISTRATION_FORM';
export const setStepOfRegistrationForm = step => ({
    type: SET_STEP_OF_REGISTRATION_FORM,
    payload: { step },
});
