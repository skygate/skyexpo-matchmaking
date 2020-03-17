import { createSelector } from 'reselect';

export const getRegistrationFormState = (state, _ownProps) => state.registrationForm;

export const getUserType = (_state, ownProps) => ownProps.userType;

export const getStep = createSelector(
    getRegistrationFormState,
    registrationForm => registrationForm.step,
);
export const getValidationErrors = createSelector(
    getRegistrationFormState,
    registrationForm => registrationForm.validationErrors,
);
export const getValidationErrorsForUserType = createSelector(
    getValidationErrors,
    getUserType,
    getStep,
    (validationErrors, userType, step) => validationErrors?.[userType]?.[step],
);
