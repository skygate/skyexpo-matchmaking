import * as registrationActions from '../actions/registrationActions';

const defaultState = {
    name: '',
    isValidating: false,
    validationErrors: {},
    step: 0,
};

export const registrationForm = (state = defaultState, action) => {
    switch (action.type) {
        case registrationActions.VALIDATE_STEP_OF_FORM_REQUESTED:
            return {
                ...state,
                isValidating: true,
            };
        case registrationActions.VALIDATE_STEP_OF_FORM_PASS_SUCCEEDED:
            const { isPassingFrontValidation } = action.payload;

            return {
                ...state,
                step: isPassingFrontValidation ? state.step + 1 : state.step,
            };
        case registrationActions.VALIDATE_STEP_OF_FORM_ERRORS_SUCCEEDED:
            const { payload } = action;
            const { validationErrors } = state;

            return {
                ...state,
                isValidating: false,
                validationErrors: {
                    ...validationErrors,
                    ...{
                        [payload.userType]: {
                            ...validationErrors[payload.userType],
                            ...{ [state.step]: payload.validationErrors || {} },
                        },
                    },
                },
            };
        case registrationActions.SET_STEP_OF_REGISTRATION_FORM:
            return {
                ...state,
                step: action.payload.step,
            };
        default:
            return state;
    }
};
