import {
    VALIDATE_FIRST_STEP_REQUESTED,
    VALIDATE_FIRST_STEP_SUCCEEDED,
    VALIDATE_FIRST_STEP_FAILED,
} from '../actions/registrationActions';

const defaultState = {
    name: '',
    isValidating: false,
};

export const registrationForm = (state = defaultState, action) => {
    switch (action.type) {
        case VALIDATE_FIRST_STEP_REQUESTED:
            return {
                ...state,
                isValidating: true,
            };
        case VALIDATE_FIRST_STEP_SUCCEEDED:
        case VALIDATE_FIRST_STEP_FAILED:
            return {
                ...state,
                isValidating: false,
            };
        default:
            return state;
    }
};
