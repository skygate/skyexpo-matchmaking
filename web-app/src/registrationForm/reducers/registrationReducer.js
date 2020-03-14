import * as registrationActions from '../actions/registrationActions';

const defaultState = {
    name: '',
    isValidating: false,
    validationErrors: {},
    step: 1,
};

export const registrationForm = (state = defaultState, action) => {
    switch (action.type) {
        case registrationActions.VALIDATE_STEP_OF_FORM_REQUESTED:
            return {
                ...state,
                isValidating: true,
            };
        case registrationActions.VALIDATE_STEP_OF_FORM_PASS_SUCCEEDED:
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
                            ...{ [payload.step]: payload.validationErrors || {} },
                        },
                    },
                },
            };
        default:
            return state;
    }
};
